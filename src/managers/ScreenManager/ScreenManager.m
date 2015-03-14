//
//  ScreenManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ScreenManager.h"

#import "RecipeScreen.h"
#import "RootScreen.h"
#import "Screen.h"
#import "SearchScreen.h"

@interface ScreenManager () <UINavigationControllerDelegate>

@property (nonatomic, weak) Screen *currentScreen;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation ScreenManager

- (void)initializeWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:[[RootScreen alloc] initWithScreenManager:self]];
        _navigationController.delegate = self;
    }
    return _navigationController;
}

#pragma mark -
#pragma mark Navigation API

- (Screen *)currentScreen {
    return (Screen *)self.navigationController.topViewController;
}

- (void)gotoRecipeScreenWithRecipe:(Recipe *)recipe {
    RecipeScreen *recipeScreen = [[RecipeScreen alloc] initWithRecipe:recipe];
    [self.navigationController pushViewController:recipeScreen animated:YES];
}

- (void)gotoSearchScreen {
    SearchScreen *searchScreen = [[SearchScreen alloc] initWithScreenManager:self];
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
