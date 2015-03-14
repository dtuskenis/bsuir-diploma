//
//  RecipeView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipeView.h"

#import "IngredientCell.h"
#import "Haneke.h"
#import "Recipe.h"

static NSTimeInterval const kAnimationDuration = 0.3;

@interface RecipeView () <UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *ingredientsActivityIndicator;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *instructionsActivityIndicator;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *subcategoryLabel;
@property (nonatomic, weak) IBOutlet UITableView *ingredientsTableView;
@property (nonatomic, weak) IBOutlet UILabel *instructionsLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titleLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *categoryLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subcategoryLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *instructionsLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ingredientsTableViewHeight;

@end

@implementation RecipeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.ingredientsTableView registerNib:[IngredientCell cellNib] forCellReuseIdentifier:[IngredientCell cellIdentifier]];
}

- (void)dealloc {
    [self.imageView hnk_cancelSetImage];
}

- (void)layoutSubviews {
    self.ingredientsTableViewHeight.constant = self.ingredientsTableView.contentSize.height;
    [super layoutSubviews];
}

- (void)fillWithRecipe:(Recipe *)recipe {
    
    /*
     Title / Category / Subcategory
     */
    self.titleLabel.attributedText = [self attributedStringWithTitle:@"" description:recipe.title];
    [self.titleLabel sizeToFit];
    self.titleLabelHeight.constant = self.titleLabel.frame.size.height;
    
    self.categoryLabel.attributedText = [self attributedStringWithTitle:@"" description:recipe.category];
    [self.categoryLabel sizeToFit];
    self.categoryLabelHeight.constant = self.categoryLabel.frame.size.height;
    
    self.subcategoryLabel.attributedText = [self attributedStringWithTitle:@"" description:recipe.subcategory];
    [self.subcategoryLabel sizeToFit];
    self.subcategoryLabelHeight.constant = self.subcategoryLabel.frame.size.height;
    
    /*
     Ingredients
     */
    [self.ingredientsTableView reloadData];
    if (recipe.ingredients) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.ingredientsActivityIndicator.alpha = 0;
            self.ingredientsTableView.alpha = 1;
            [self layoutIfNeeded];
        }];
        [self.ingredientsTableView reloadData];
    } else {
        self.ingredientsActivityIndicator.alpha = 1;
        self.ingredientsTableView.alpha = 0;
        self.ingredientsTableViewHeight.constant = 0;
        [self.ingredientsTableView reloadData];
    }
    
    /*
     Instructions
     */
    if (recipe.instructions) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.instructionsActivityIndicator.alpha = 0;
            self.instructionsLabel.alpha = 1;
        }];
        self.instructionsLabel.text = recipe.instructions;
        [self.instructionsLabel sizeToFit];
        self.instructionsLabelHeight.constant = self.instructionsLabel.frame.size.height;

    } else {
        self.instructionsActivityIndicator.alpha = 1;
        self.instructionsLabel.text = @"";
        self.instructionsLabel.alpha = 0;
        self.instructionsLabelHeight.constant = 0;
    }
    
    /*
     Image
     */
    if ([recipe isEqual:self.recipe] == NO || self.imageView.image == nil) {
        self.imageView.alpha = 0;
        self.activityIndicator.alpha = 1;
    }
    [self.imageView hnk_setImageFromURL:[NSURL URLWithString:recipe.imageURL] placeholder:nil success:^(UIImage *image) {
        self.imageView.image = image;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.imageView.alpha = 1;
            self.activityIndicator.alpha = 0;
        }];
    } failure:^(NSError *error) {}];
    
    /*
     Post
     */
    [self layoutIfNeeded];
}

#pragma mark -
#pragma mark Property

- (void)setRecipe:(Recipe *)recipe {
    _recipe = recipe;
    [self fillWithRecipe:recipe];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipe.ingredients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientCell *cell = [tableView dequeueReusableCellWithIdentifier:[IngredientCell cellIdentifier] forIndexPath:indexPath];
    
    cell.item = self.recipe.ingredients[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Helpers

- (NSAttributedString *)attributedStringWithTitle:(NSString *)title description:(NSString *)description {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:description ? description : @""]];
    
    return [[NSAttributedString alloc] initWithAttributedString:attributedString];
}

@end
