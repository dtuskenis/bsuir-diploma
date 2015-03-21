//
//  ConfigurationManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ConfigurationManager.h"

#import "RecipesCategory.h"
#import "ServiceManager.h"

@interface ConfigurationManager ()

@property (nonatomic, strong) ServiceManager *serviceManager;

@end

@implementation ConfigurationManager

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager {
    self = [super init];
    if (self) {
        self.serviceManager = serviceManager;
        [self loadDefaultConfiguration];
    }
    return self;
}

- (void)loadDefaultConfiguration {
    
    NSArray *categoriesFromConfig = [self objectFromConfigWithName:@"categories.json"];
    NSMutableArray *categories = [NSMutableArray array];
    for (NSDictionary *category in categoriesFromConfig) {
        [categories addObject:[[RecipesCategory alloc] initWithDictionary:category error:NULL]];
    }
    self.recipesCategories = [NSArray arrayWithArray:categories];
    
}

#pragma mark -
#pragma mark Helpers

- (id)objectFromConfigWithName:(NSString *)configName {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:configName]];
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return object;
}

@end
