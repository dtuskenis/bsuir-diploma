//
//  ScreenManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ScreenManager.h"

#import "RecipeScreen.h"
#import "RecipesManager.h"
#import "RootScreen.h"
#import "Screen.h"
#import "SearchScreen.h"
#import "ServiceProvider.h"

@interface ScreenManager () <UINavigationControllerDelegate>

@property (nonatomic, weak) Screen *currentScreen;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) RootScreen *rootScreen;

@property (nonatomic, strong) id<ServiceProvider> serviceProvider;

@end

@implementation ScreenManager

- (instancetype)initWithServiceProvider:(id<ServiceProvider>)serviceProvider {
    self = [super init];
    if (self) {
        self.serviceProvider = serviceProvider;
    }
    return self;
}

- (void)initializeWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.rootScreen];
        _navigationController.delegate = self;
    }
    return _navigationController;
}

- (RootScreen *)rootScreen {
    if (_rootScreen == nil) {
        _rootScreen = [[RootScreen alloc] initWithRecipesManager:[self.serviceProvider getServiceWithClass:[RecipesManager class]]
                                                   screenManager:self];
    }
    return _rootScreen;
}

#pragma mark -
#pragma mark Navigation API

- (Screen *)currentScreen {
    return (Screen *)self.navigationController.topViewController;
}

- (void)gotoRecipeScreenWithRecipe:(Recipe *)recipe {
    RecipeScreen *recipeScreen = [[RecipeScreen alloc] initWithRecipe:recipe
                                                       recipesManager:[self.serviceProvider getServiceWithClass:[RecipesManager class]]
                                                        screenManager:self];
    [self.navigationController pushViewController:recipeScreen animated:YES];
}

- (void)gotoSearchScreen {
    SearchScreen *searchScreen = [[SearchScreen alloc] initWithRecipesManager:[self.serviceProvider getServiceWithClass:[RecipesManager class]]
                                                                screenManager:self];
    [self.navigationController pushViewController:searchScreen animated:YES];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.currentScreen = (Screen *)viewController;
}

@end
