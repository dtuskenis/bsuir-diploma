//
//  CategoriesView.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipesCategory;

@protocol CategoriesViewDelegate;

@interface CategoriesView : UIView

@property (nonatomic, weak) IBOutlet id<CategoriesViewDelegate> delegate;

@property (nonatomic, strong) NSArray *categories;

@end

@protocol CategoriesViewDelegate <NSObject>

@optional
- (void)categoriesView:(CategoriesView *)view didSelectCategory:(RecipesCategory *)category;

@end
