//
//  APIIngredient.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@class APIIngredientInformation;

@interface APIIngredient : JSONModel

@property (nonatomic, assign) NSInteger ingredientId;
@property (nonatomic, assign) NSInteger displayIndex;
@property (nonatomic, assign) BOOL isHeading;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) CGFloat quantity;
@property (nonatomic, strong) NSString* displayQuantity;
@property (nonatomic, strong) NSString* unit;
@property (nonatomic, assign) CGFloat metricQuantity;
@property (nonatomic, strong) NSString* metricDisplayQuantity;
@property (nonatomic, strong) NSString* metricUnit;
@property (nonatomic, strong) NSString* preparationNotes;
@property (nonatomic, strong) APIIngredientInformation* information;
@property (nonatomic, assign) BOOL isLinked;

@end
