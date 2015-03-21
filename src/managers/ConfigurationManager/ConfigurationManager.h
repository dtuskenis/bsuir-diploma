//
//  ConfigurationManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServiceManager;

@interface ConfigurationManager : NSObject

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager;

@property (nonatomic, strong) NSArray *recipesCategories;

@end
