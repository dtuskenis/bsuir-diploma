//
//  APIRecipe.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APIRecipe.h"

@implementation APIRecipe

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
                           @"Ingredients" : @"ingredients",
                           @"Instructions" : @"instructions"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:keys];
}

@end
