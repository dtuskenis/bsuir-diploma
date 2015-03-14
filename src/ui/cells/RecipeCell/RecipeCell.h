//
//  RecipeCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CollectionViewCell.h"

@class Recipe;

@interface RecipeCell : CollectionViewCell

@property (nonatomic, strong) Recipe *item;

@end
