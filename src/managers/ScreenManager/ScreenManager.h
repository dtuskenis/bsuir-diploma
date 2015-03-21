//
//  ScreenManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;
@class Screen;
@class SearchRequest;

@protocol ServiceProvider;

@interface ScreenManager : NSObject

@property (nonatomic, weak, readonly) Screen *currentScreen;

- (instancetype)initWithServiceProvider:(id<ServiceProvider>)serviceProvider;

- (void)initializeWindow;

- (void)gotoRecipeScreenWithRecipe:(Recipe *)recipe;
- (void)gotoSearchScreen;
- (void)gotoSearchScreenWithSearchRequest:(SearchRequest *)searchRequest;
- (void)switchToSearchScreen;
- (void)switchToCategoriesScreen;

- (void)goBack;

@end
