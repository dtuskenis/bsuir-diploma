//
//  RecipeScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipeScreen.h"

#import "FavoriteButton.h"
#import "Recipe.h"
#import "RecipesManager.h"

@interface RecipeScreen ()

@property (nonatomic, strong) Recipe *recipe;

@end

@implementation RecipeScreen

- (instancetype)initWithRecipe:(Recipe *)recipe {
    self = [super initWithScreenManager:nil];
    if (self) {
        self.recipe = recipe;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.recipe = self.recipe;
    
    FavoriteButton *favoriteButton = [[FavoriteButton alloc] init];
    [favoriteButton setSelected:[[RecipesManager sharedInstance] isFavoriteRecipe:self.recipe]];
    [favoriteButton addTarget:self action:@selector(favoriteButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"Details";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[RecipesManager sharedInstance] getRecipeWithIdentifier:self.recipe.identifier successBlock:^(Recipe *recipe) {
        self.view.recipe = recipe;
        [[RecipesManager sharedInstance] setRecipeRecentlyViewed:self.recipe];
    } failureBlock:^(NSError *error) {}];
}

- (IBAction)favoriteButtonTouched:(FavoriteButton *)sender {
    if (sender.selected) {
        [[RecipesManager sharedInstance] addRecipeToFavorites:self.recipe];
    } else {
        [[RecipesManager sharedInstance] removeRecipeFromFavorites:self.recipe];
    }
}

@end
