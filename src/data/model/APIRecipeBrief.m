//
//  APIRecipeBrief.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APIRecipeBrief.h"

@implementation APIRecipeBrief

+ (JSONKeyMapper *)keyMapper {
    NSDictionary *keys = @{
                           @"RecipeID" : @"recipeId",
                           @"Title" : @"title",
                           @"Cuisine" : @"cuisine",
                           @"Category" : @"category",
                           @"Subcategory" : @"subcategory",
                           @"StarRating" : @"rating",
                           @"ImageURL" : @"imageURL",
                           @"YieldNumber" : @"yieldNumber",
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:keys];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
