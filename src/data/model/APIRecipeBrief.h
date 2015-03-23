//
//  APIRecipeBrief.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@interface APIRecipeBrief : JSONModel

@property (nonatomic, assign) NSInteger recipeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cuisine;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *subcategory;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, assign) NSInteger yieldNumber;

@end
