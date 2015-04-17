//
//  SearchManager.h
//  ChefsBuddy
//
//  Created by Tuskenis, Denis on 4/16/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchRequest;
@class ServiceManager;

@interface SearchManager : NSObject

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager;

- (void)searchRecipesWithRequest:(SearchRequest *)searchRequest
                    successBlock:(void (^)(NSArray *searchResults))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

@end
