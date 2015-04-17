//
//  SearchScreen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "SearchView.h"

@class SearchManager;
@class SearchRequest;

@interface SearchScreen : Screen

@property (nonatomic, strong) SearchView *view;

- (instancetype)initWithSearchManager:(SearchManager *)searchManager
                        screenManager:(ScreenManager *)screenManager;

- (instancetype)initWithSearchRequest:(SearchRequest *)searchRequest
                        searchManager:(SearchManager *)searchManager
                        screenManager:(ScreenManager *)screenManager;

@end
