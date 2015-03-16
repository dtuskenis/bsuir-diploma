//
//  RecipeScreen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "RecipeView.h"

@class Recipe;
@class RecipesManager;

@interface RecipeScreen : Screen

@property (nonatomic, strong) RecipeView *view;

- (instancetype)initWithRecipe:(Recipe *)recipe
                recipesManager:(RecipesManager *)recipesManager
                 screenManager:(ScreenManager *)screenManager;

@end
