//
//  ServiceManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/31/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ServiceManager.h"

#import "AFNetworking.h"
#import "APIDataConverter.h"
#import "APIModel.h"
#import "CacheManager.h"
#import "Recipe.h"

static NSString *const kApiKey = @"dvx1uR0PxjsBp5PU5bNzr2NA7M1IC1mv";
static NSString *const kApiEndpoint = @"http://api.bigoven.com/";
static NSString *const kApiContentType = @"application/json";

@implementation ServiceManager

- (void)searchRecipesWithRequest:(SearchRequest *)request
                    successBlock:(void (^)(NSArray *recipes))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock {
    APISearchRequest *searchRequest = [APIDataConverter APISearchRequestWithSearchRequest:request APIKey:kApiKey];
    
    NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                    URLString:[self URLForSearch]
                                                                                   parameters:[searchRequest toDictionary]
                                                                                        error:nil];
    [urlRequest setValue:kApiContentType forHTTPHeaderField:@"Content-Type"];
    
    [[CacheManager sharedInstance] objectForKey:urlRequest.URL.absoluteString recieveBlock:^(id object) {
        if (object) {
            successBlock(object);
        } else {
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSError *error = nil;
                APISearchResult *searchResult = [[APISearchResult alloc] initWithData:responseObject error:&error];
                if (error == nil) {
                    NSArray *searchResults = [APIDataConverter searchResultsWithAPISearchResult:searchResult];
                    [[CacheManager sharedInstance] cacheObject:searchResults forKey:urlRequest.URL.absoluteString completionBlock:^{}];
                    successBlock(searchResults);
                } else {
                    failureBlock(error);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock(error);
            }];
            [operation start];
        }
    }];
}

- (void)getRecipeWithIdentifier:(NSString *)identifier
                   successBlock:(void (^)(Recipe *recipe))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock {
    NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                    URLString:[self URLForRecipeWithIdentifier:identifier]
                                                                                   parameters:@{ @"api_key" : kApiKey }
                                                                                        error:nil];
    [urlRequest setValue:kApiContentType forHTTPHeaderField:@"Content-Type"];
    
    [[CacheManager sharedInstance] objectForKey:urlRequest.URL.absoluteString recieveBlock:^(id object) {
        if (object) {
            successBlock(object);
        } else {
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSError *error = nil;
                APIRecipe *apiRecipe = [[APIRecipe alloc] initWithData:responseObject error:&error];
                if (error == nil) {
                    Recipe *recipe = [APIDataConverter recipeWithAPIRecipe:apiRecipe];
                    [[CacheManager sharedInstance] cacheObject:recipe forKey:urlRequest.URL.absoluteString completionBlock:^{}];
                    successBlock(recipe);
                } else {
                    failureBlock(error);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock(error);
            }];
            [operation start];
        }
    }];
}

#pragma mark -
#pragma mark Helpers

- (NSString *)URLForSearch {
    return [kApiEndpoint stringByAppendingPathComponent:@"recipes"];
}

- (NSString *)URLForRecipeWithIdentifier:(NSString *)identifier {
    return [[kApiEndpoint stringByAppendingPathComponent:@"recipe"] stringByAppendingPathComponent:identifier];
}

@end
