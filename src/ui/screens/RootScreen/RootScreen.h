//
//  RootScreen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "RootView.h"

@class RecipesManager;

@interface RootScreen : Screen

@property (nonatomic, strong) RootView *view;

- (instancetype)initWithRecipesManager:(RecipesManager *)recipesManager
                         screenManager:(ScreenManager *)screenManager;

@end
