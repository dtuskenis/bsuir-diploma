//
//  RecipesListViewController.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipesListViewController.h"

#import "RecipesListView.h"

@interface RecipesListViewController () <RecipesListViewDelegate>

@property (nonatomic, strong) RecipesListView *view;

@end

@implementation RecipesListViewController

- (instancetype)initWithRecipes:(NSArray *)recipes {
    self = [super init];
    if (self) {
        self.recipes = recipes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark Property

- (NSArray *)recipes {
    return self.view.recipes;
}

- (void)setRecipes:(NSArray *)recipes {
    self.view.recipes = recipes;
}

#pragma mark -
#pragma mark RecipesListViewDelegate

- (void)recipesListView:(RecipesListView *)view didSelectRecipe:(Recipe *)recipe {
    if ([self.delegate respondsToSelector:@selector(recipesListViewController:didSelectRecipe:)]) {
        [self.delegate recipesListViewController:self didSelectRecipe:recipe];
    }
}

@end
