//
//  ServiceManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/31/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ServiceManager.h"

#import "AFNetworking.h"
#import "APIModel.h"
#import "CacheManager.h"
#import "DataConverter.h"
#import "Recipe.h"

static NSString *const kApiKey = @"dvx1uR0PxjsBp5PU5bNzr2NA7M1IC1mv";
static NSString *const kApiEndpoint = @"http://api.bigoven.com/";
static NSString *const kApiContentType = @"application/json";

@implementation ServiceManager

- (void)searchRecipesWithRequest:(SearchRequest *)request
                    successBlock:(void (^)(NSArray *recipes))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock {
    DataConverter *converter = [[DataConverter alloc] init];
    [converter convertObjectWithObject:request successBlock:^(id object) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[(JSONModel*)object toDictionary]];
        [dictionary addEntriesFromDictionary:@{ @"api_key" : kApiKey}];
        NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                        URLString:[self URLForSearch]
                                                                                       parameters:dictionary
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
                        [converter convertObjectWithObject:searchResult successBlock:^(id object) {
                            [[CacheManager sharedInstance] cacheObject:object forKey:urlRequest.URL.absoluteString completionBlock:^{}];
                            successBlock(object);
                        } failureBlock:failureBlock];
                    } else {
                        failureBlock(error);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failureBlock(error);
                }];
                [operation start];
            }
        }];
    } failureBlock:failureBlock];
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
                APIRecipe *recipe = [[APIRecipe alloc] initWithData:responseObject error:&error];
                if (error == nil) {
                    DataConverter *converter = [[DataConverter alloc] init];
                    [converter convertObjectWithObject:recipe successBlock:^(id object) {
                        [[CacheManager sharedInstance] cacheObject:object forKey:urlRequest.URL.absoluteString completionBlock:^{}];
                        successBlock(object);
                    } failureBlock:failureBlock];
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
