//
//  APIIngredientInformation.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@interface APIIngredientInformation : JSONModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *department;

@end
