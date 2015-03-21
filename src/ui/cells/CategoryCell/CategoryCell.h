//
//  CategoryCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "TableViewCell.h"

@class RecipesCategory;

@interface CategoryCell : TableViewCell

@property (nonatomic, strong) RecipesCategory *item;

@end
