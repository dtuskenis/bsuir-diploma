//
//  APISearchResult.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APISearchResult.h"

@implementation APISearchResult

+ (JSONKeyMapper *)keyMapper {
    NSDictionary *keys = @{
                           @"ResultCount" : @"resultsCount",
                           @"Results" : @"results"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:keys];
}

@end
