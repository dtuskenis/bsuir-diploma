//
//  ConfigurationManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ConfigurationManager.h"

#import "ServiceManager.h"

@interface ConfigurationManager ()

@property (nonatomic, strong) ServiceManager *serviceManager;

@end

@implementation ConfigurationManager

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager {
    self = [super init];
    if (self) {
        self.serviceManager = serviceManager;
    }
    return self;
}

@end
