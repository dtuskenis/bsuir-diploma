//
//  SearchView.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@protocol SearchViewDelegate;

@interface SearchView : UIView

@property (nonatomic, weak) IBOutlet id<SearchViewDelegate> delegate;

@property (nonatomic, strong) NSArray *searchResults;

- (void)beginRefreshing;
- (void)endRefreshing;

- (void)hideSearchBar;
- (void)hideKeyboard;

@end

@protocol SearchViewDelegate <NSObject>

@optional
- (void)searchView:(SearchView *)view didChangeSearchText:(NSString *)searchText;
- (void)searchView:(SearchView *)view didSelectRecipe:(Recipe *)recipe;
- (void)searchViewNeedMoreData:(SearchView *)view;

@end
