//
//  SearchScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchScreen.h"

#import "IndicatorController.h"
#import "SearchManager.h"
#import "SearchRequest.h"
#import "UIBarButtonItem+Custom.h"

static NSInteger const kSearchResultsPageSize = 30;

@interface SearchScreen () <SearchViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) SearchManager *searchManager;
@property (nonatomic, strong) SearchRequest *searchRequest;

@end

@implementation SearchScreen

- (instancetype)initWithSearchManager:(SearchManager *)searchManager
                        screenManager:(ScreenManager *)screenManager {
    return [self initWithSearchRequest:nil searchManager:searchManager screenManager:screenManager];
}

- (instancetype)initWithSearchRequest:(SearchRequest *)searchRequest
                        searchManager:(SearchManager *)searchManager
                        screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        self.searchManager = searchManager;
        self.searchRequest = searchRequest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Search", nil);
    
    if (self.searchRequest == nil) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem arrowsItemWithTarget:self action:@selector(arrowsButtonTouched:)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.searchRequest && self.view.searchResults.count == 0) {
        self.view.searchBar.hidden = YES;
        [self.view layoutIfNeeded];
        
        [[IndicatorController sharedInstance] showIndicatorWithTitle:@"Searching..."];
        [self.view beginRefreshing];
        [self.searchManager searchRecipesWithRequest:self.searchRequest successBlock:^(NSArray *searchResults) {
            self.view.searchResults = searchResults;
            [self.view endRefreshing];
            [[IndicatorController sharedInstance] hideIndicator];
        } failureBlock:^(NSError *error) {
            [self.view endRefreshing];
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
    if (self.searchRequest == nil) {
        self.searchRequest = [[SearchRequest alloc] init];
        self.searchRequest.ingredients = @[];
    }
    self.searchRequest.keywords = [searchText componentsSeparatedByString:@" "];
    self.searchRequest.searchRange = NSMakeRange(0, kSearchResultsPageSize);
    
    [self search];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Private

- (void)search {
    [self.view beginRefreshing];
    [self.searchManager searchRecipesWithRequest:self.searchRequest successBlock:^(NSArray *searchResults) {
        self.view.searchResults = [self.view.searchResults arrayByAddingObjectsFromArray:searchResults];
        [self.view endRefreshing];
    } failureBlock:^(NSError *error) {
        [self.view endRefreshing];
    }];
}

- (void)increaseSearchRange {
    NSRange currentRange = self.searchRequest.searchRange;
    self.searchRequest.searchRange = NSMakeRange(currentRange.location + kSearchResultsPageSize, kSearchResultsPageSize);
}

#pragma mark -
#pragma mark SearchViewDelegate

- (void)searchView:(SearchView *)view didSelectRecipe:(Recipe *)recipe {
    [self.screenManager gotoRecipeScreenWithRecipe:recipe];
}

- (void)searchViewNeedMoreData:(SearchView *)view {
    [self increaseSearchRange];
    [self search];
}

@end
