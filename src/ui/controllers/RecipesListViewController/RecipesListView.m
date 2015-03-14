//
//  RecipesListView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipesListView.h"

#import "Recipe.h"
#import "RecipeCell.h"
#import "UIColor+Custom.h"

@interface RecipesListView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UIView *placeholderView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation RecipesListView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[RecipeCell cellNib] forCellWithReuseIdentifier:[RecipeCell cellIdentifier]];
}

#pragma mark -
#pragma mark Property

- (void)setRecipes:(NSArray *)recipes {
    _recipes = recipes;
    [self.collectionView reloadData];
    [self updateAnimated:NO];
}

- (void)updateAnimated:(BOOL)animated {
    NSTimeInterval animationDuration = animated ? 0.3 : 0;
    
    BOOL showPlaceholder = (self.recipes.count == 0);
    [UIView animateWithDuration:animationDuration animations:^{
        self.collectionView.alpha = showPlaceholder ? 0 : 1;
        self.placeholderView.alpha = showPlaceholder ? 1 : 0;
    } completion:^(BOOL finished) {}];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recipes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecipeCell cellIdentifier] forIndexPath:indexPath];
    
    cell.item = self.recipes[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RecipeCell *cell = (RecipeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(recipesListView:didSelectRecipe:)]) {
        [self.delegate recipesListView:self didSelectRecipe:cell.item];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / 2 - 2, collectionView.frame.size.width / 2);
}

@end
