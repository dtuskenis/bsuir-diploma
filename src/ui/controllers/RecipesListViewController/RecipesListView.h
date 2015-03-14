//
//  RecipesListView.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@protocol RecipesListViewDelegate;

@interface RecipesListView : UIView

@property (nonatomic, weak) IBOutlet id<RecipesListViewDelegate> delegate;

@property (nonatomic, readwrite) NSArray *recipes;

- (void)updateAnimated:(BOOL)animated;

@end

@protocol RecipesListViewDelegate <NSObject>

@optional
- (void)recipesListView:(RecipesListView *)view didSelectRecipe:(Recipe *)recipe;

@end
