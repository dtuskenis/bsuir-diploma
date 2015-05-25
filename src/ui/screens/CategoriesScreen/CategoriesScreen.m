//
//  CategoriesScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CategoriesScreen.h"

#import "ConfigurationManager.h"
#import "IndicatorController.h"
#import "SearchRequest.h"
#import "UIBarButtonItem+Custom.h"
#import "UINavigationItem+Custom.h"

@interface CategoriesScreen () <CategoriesViewDelegate>

@property (nonatomic, strong) ConfigurationManager *configurationManager;

@end

@implementation CategoriesScreen

- (instancetype)initWithConfigurationManager:(ConfigurationManager *)configurationManager
                               screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        self.configurationManager = configurationManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.customTitle = NSLocalizedString(@"Categories", nil);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem arrowsItemWithTarget:self action:@selector(arrowsButtonTouched:)];
    
    self.view.categories = [NSArray arrayWithArray:self.configurationManager.recipesCategories];
}

#pragma mark -
#pragma mark Actions

- (IBAction)arrowsButtonTouched:(id)sender {
    [self.screenManager switchToSearchScreen];
}

#pragma mark -
#pragma mark CategoriesViewDelegate

- (void)categoriesView:(CategoriesView *)view didSelectCategory:(RecipesCategory *)category {
    SearchRequest *searchRequest = [[SearchRequest alloc] init];
    searchRequest.categories = @[category];
    searchRequest.searchRange = NSMakeRange(0, 30);
    [self.screenManager gotoSearchScreenWithSearchRequest:searchRequest];
}

@end
