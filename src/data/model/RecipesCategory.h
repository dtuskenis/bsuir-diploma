//
//  RecipesCategory.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@interface RecipesCategory : JSONModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageURL;

@end
