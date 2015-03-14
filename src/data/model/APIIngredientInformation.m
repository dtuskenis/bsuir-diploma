//
//  APIIngredientInformation.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APIIngredientInformation.h"

@implementation APIIngredientInformation

+ (JSONKeyMapper *)keyMapper {
    NSDictionary *keys = @{
                           @"Name" : @"name",
                           @"Department" : @"department"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:keys];
}

@end
