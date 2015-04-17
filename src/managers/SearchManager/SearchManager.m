//
//  SearchManager.m
//  ChefsBuddy
//
//  Created by Tuskenis, Denis on 4/16/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchManager.h"

#import "ServiceManager.h"

@interface SearchManager ()

@property (nonatomic, strong) ServiceManager *serviceManager;

@end

@implementation SearchManager

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager {
    self = [super init];
    if (self) {
        self.serviceManager = serviceManager;
    }
    return self;
}

- (void)searchRecipesWithRequest:(SearchRequest *)searchRequest
                    successBlock:(void (^)(NSArray *searchResults))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock {
    [self.serviceManager searchRecipesWithRequest:searchRequest successBlock:successBlock failureBlock:failureBlock];
}

@end
