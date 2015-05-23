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

@property (nonatomic, strong) RecipesManager *recipesManager;

@end

@implementation RecipeScreen

- (instancetype)initWithRecipe:(Recipe *)recipe
                recipesManager:(RecipesManager *)recipesManager
                 screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        self.recipe = recipe;
        self.recipesManager = recipesManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.recipe = self.recipe;
    
    FavoriteButton *favoriteButton = [[FavoriteButton alloc] init];
    [favoriteButton setSelected:[self.recipesManager isFavoriteRecipe:self.recipe]];
    [favoriteButton addTarget:self action:@selector(favoriteButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"Details";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.recipesManager getRecipeWithIdentifier:self.recipe.identifier successBlock:^(Recipe *recipe) {
        self.view.recipe = recipe;
        [self.recipesManager setRecipeRecentlyViewed:self.recipe];
    } failureBlock:^(NSError *error) {
        [self handleError:error];
    }];
}

- (IBAction)favoriteButtonTouched:(FavoriteButton *)sender {
    if (sender.selected) {
        [self.recipesManager addRecipeToFavorites:self.recipe];
    } else {
        [self.recipesManager removeRecipeFromFavorites:self.recipe];
    }
}

@end
