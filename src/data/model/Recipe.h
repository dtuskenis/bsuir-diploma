//
//  Recipe.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Model.h"

@interface Recipe : Model

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cuisine;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *subcategory;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, assign) NSInteger yield;
@property (nonatomic, assign) NSInteger rating;

@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSString *instructions;

@end
