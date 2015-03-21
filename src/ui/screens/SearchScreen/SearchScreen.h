//
//  SearchScreen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "SearchView.h"

@class RecipesManager;
@class SearchRequest;

@interface SearchScreen : Screen

@property (nonatomic, strong) SearchView *view;

- (instancetype)initWithRecipesManager:(RecipesManager *)recipesManager
                         screenManager:(ScreenManager *)screenManager;

- (instancetype)initWithSearchRequest:(SearchRequest *)searchRequest
                       recipesManager:(RecipesManager *)recipesManager
                        screenManager:(ScreenManager *)screenManager;

@end
