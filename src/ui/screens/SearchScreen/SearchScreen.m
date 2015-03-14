//
//  SearchScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchScreen.h"

#import "RecipesManager.h"
#import "SearchRequest.h"

@interface SearchScreen () <SearchViewDelegate, UISearchBarDelegate>

@end

@implementation SearchScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Search", nil);
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    SearchRequest *searchRequest = [[SearchRequest alloc] init];
    searchRequest.keywords = [searchText componentsSeparatedByString:@" "];
    searchRequest.ingredients = @[];
    searchRequest.searchRange = NSMakeRange(0, 30);
    
    [self.view beginRefreshing];
    [[RecipesManager sharedInstance] searchRecipesWithRequest:searchRequest successBlock:^(NSArray *searchResults) {
        self.view.searchResults = searchResults;
        [self.view endRefreshing];
    } failureBlock:^(NSError *error) {
        [self.view endRefreshing];
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark SearchViewDelegate

- (void)searchView:(SearchView *)view didSelectRecipe:(Recipe *)recipe {
    [self.screenManager gotoRecipeScreenWithRecipe:recipe];
}

@end
