//
//  ServiceManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/31/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@class Recipe;
@class SearchRequest;

@interface ServiceManager : SharedInstance

- (void)searchRecipesWithRequest:(SearchRequest *)searchRequest
                    successBlock:(void (^)(NSArray *recipes))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

- (void)getRecipeWithIdentifier:(NSString *)identifier
                   successBlock:(void (^)(Recipe *recipe))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

@end
