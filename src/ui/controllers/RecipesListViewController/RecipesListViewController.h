//
//  RecipesListViewController.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@protocol RecipesListViewControllerDelegate;

@interface RecipesListViewController : UIViewController

@property (nonatomic, weak) id<RecipesListViewControllerDelegate> delegate;

@property (nonatomic, readwrite) NSArray *recipes;

- (instancetype)initWithRecipes:(NSArray *)recipes;

@end

@protocol RecipesListViewControllerDelegate <NSObject>

@optional
- (void)recipesListViewController:(RecipesListViewController *)controller didSelectRecipe:(Recipe *)recipe;

@end
