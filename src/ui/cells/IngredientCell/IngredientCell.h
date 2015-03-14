//
//  IngredientCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/5/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "TableViewCell.h"

@class Ingredient;

@interface IngredientCell : TableViewCell

@property (nonatomic, strong) Ingredient *item;

@end
