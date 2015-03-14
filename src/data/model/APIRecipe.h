//
//  APIRecipe.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@protocol APIIngredient
@end

@interface APIRecipe : JSONModel

@property (nonatomic, assign) NSInteger recipeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString<Optional> *cuisine;
@property (nonatomic, strong) NSString<Optional> *category;
@property (nonatomic, strong) NSString<Optional> *subcategory;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, assign) NSInteger yieldNumber;

@property (nonatomic, strong) NSArray<APIIngredient> *ingredients;
@property (nonatomic, strong) NSString *instructions;

@end
