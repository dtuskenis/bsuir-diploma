//
//  RootScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RootScreen.h"

#import "MenuViewContainer.h"
#import "RecipesListViewController.h"
#import "RecipesManager.h"
#import "UIBarButtonItem+Custom.h"

static NSString* const kRecentRecipes = @"Recent";
static NSString* const kFavorites = @"Favorites";
static NSString* const kCategories = @"Categories";

@interface RootScreen () <RecipesListViewControllerDelegate>

@property (nonatomic, weak) IBOutlet MenuViewContainer *menuViewContainer;

@property (nonatomic, strong) RecipesListViewController *recentRecipesListViewController;
@property (nonatomic, strong) RecipesListViewController *favoriteRecipesListViewController;

@property (nonatomic, strong) RecipesManager *recipesManager;

@end

@implementation RootScreen

- (instancetype)initWithRecipesManager:(RecipesManager *)recipesManager
                         screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        self.recipesManager = recipesManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(kRecentRecipes, nil);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem menuItemWithTarget:self action:@selector(menuButtonTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem searchItemWithTarget:self action:@selector(searchButtonTouched:)];
    
    [self configureMenu];
    
    self.recentRecipesListViewController = [[RecipesListViewController alloc] initWithRecipes:self.recipesManager.recent];
    self.recentRecipesListViewController.delegate = self;
    
    self.favoriteRecipesListViewController = [[RecipesListViewController alloc] initWithRecipes:self.recipesManager.favorites];
    self.favoriteRecipesListViewController.delegate = self;
    
    [self.view performTransitionToView:self.recentRecipesListViewController.view animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.recentRecipesListViewController.recipes = self.recipesManager.recent;
    self.favoriteRecipesListViewController.recipes = self.recipesManager.favorites;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view hideMenu];
}

#pragma mark -
#pragma mark Configuration

- (void)configureMenu {
    [self.menuViewContainer.view addItemWithTitle:kRecentRecipes icon:[UIImage imageNamed:@"icon_recent"] action:^{
        [self.view hideMenu];
        [self.view performTransitionToView:self.recentRecipesListViewController.view animated:YES];
        self.navigationItem.title = kRecentRecipes;
    }];
    [self.menuViewContainer.view addItemWithTitle:kFavorites icon:[UIImage imageNamed:@"icon_favorite_no"] action:^{
        [self.view hideMenu];
        [self.view performTransitionToView:self.favoriteRecipesListViewController.view animated:YES];
        self.navigationItem.title = kFavorites;
    }];
    [self.menuViewContainer.view addItemWithTitle:kCategories icon:[UIImage imageNamed:@"icon_list"] action:^{
        [self.view hideMenu];
        self.navigationItem.title = kCategories;
    }];
}

#pragma mark -
#pragma mark Actions

- (IBAction)menuButtonTouched:(id)sender {
    [self.view toggleMenu];
}

- (IBAction)searchButtonTouched:(id)sender {
    [self.screenManager gotoSearchScreen];
}

#pragma mark -
#pragma mark RecipesListViewControllerDelegate

- (void)recipesListViewController:(RecipesListViewController *)controller didSelectRecipe:(Recipe *)recipe {
    [self.screenManager gotoRecipeScreenWithRecipe:recipe];
}

@end
