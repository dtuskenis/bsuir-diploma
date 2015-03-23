//
//  APIIngredient.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APIIngredient.h"

@implementation APIIngredient

+ (JSONKeyMapper *)keyMapper {
    NSDictionary *keys = @{
                           @"IngredientID" : @"ingredientId",
                           @"DisplayIndex" : @"displayIndex",
                           @"IsHeading" : @"isHeading",
                           @"Name" : @"name",
                           @"Quantity" : @"quantity",
                           @"DisplayQuantity" : @"displayQuantity",
                           @"Unit" : @"unit",
                           @"MetricQuantity" : @"metricQuantity",
                           @"MetricDisplayQuantity" : @"metricDisplayQuantity",
                           @"MetricUnit" : @"metricUnit",
                           @"PreparationNotes" : @"preparationNotes",
                           @"IngredientInfo" : @"information",
                           @"IsLinked" : @"isLinked"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:keys];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
