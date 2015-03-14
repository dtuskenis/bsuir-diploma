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

@interface RecipeScreen : Screen

@property (nonatomic, strong) RecipeView *view;

- (instancetype)initWithRecipe:(Recipe *)recipe;

@end
