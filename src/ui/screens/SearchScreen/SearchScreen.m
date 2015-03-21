//
//  SearchScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchScreen.h"

#import "IndicatorController.h"
#import "RecipesManager.h"
#import "SearchRequest.h"
#import "UIBarButtonItem+Custom.h"

@interface SearchScreen () <SearchViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) RecipesManager *recipesManager;
@property (nonatomic, strong) SearchRequest *searchRequest;

@end

@implementation SearchScreen

- (instancetype)initWithRecipesManager:(RecipesManager *)recipesManager
                         screenManager:(ScreenManager *)screenManager {
    return [self initWithSearchRequest:nil recipesManager:recipesManager screenManager:screenManager];
}

- (instancetype)initWithSearchRequest:(SearchRequest *)searchRequest
                       recipesManager:(RecipesManager *)recipesManager
                        screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        self.recipesManager = recipesManager;
        self.searchRequest = searchRequest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Search", nil);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem arrowsItemWithTarget:self action:@selector(arrowsButtonTouched:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.searchRequest) {
        self.view.searchBar.hidden = YES;
        [self.view layoutIfNeeded];
        
        [[IndicatorController sharedInstance] showIndicatorWithTitle:@"Searching..."];
        [self.recipesManager searchRecipesWithRequest:self.searchRequest successBlock:^(NSArray *searchResults) {
            self.view.searchResults = searchResults;
            [[IndicatorController sharedInstance] hideIndicator];
        } failureBlock:^(NSError *error) {
            [[IndicatorController sharedInstance] hideIndicator];
        }];
    }
}
                                              
#pragma mark -
#pragma mark Actions

- (IBAction)arrowsButtonTouched:(id)sender {
    [self.screenManager switchToCategoriesScreen];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    SearchRequest *searchRequest = [[SearchRequest alloc] init];
    searchRequest.keywords = [searchText componentsSeparatedByString:@" "];
    searchRequest.ingredients = @[];
    searchRequest.searchRange = NSMakeRange(0, 30);
    
    [self.view beginRefreshing];
    [self.recipesManager searchRecipesWithRequest:searchRequest successBlock:^(NSArray *searchResults) {
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
