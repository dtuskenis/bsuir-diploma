//
//  CategoriesScreen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "CategoriesView.h"

@class ConfigurationManager;

@interface CategoriesScreen : Screen

@property (nonatomic, strong) CategoriesView *view;

- (instancetype)initWithConfigurationManager:(ConfigurationManager *)configurationManager
                               screenManager:(ScreenManager *)screenManager;

@end
