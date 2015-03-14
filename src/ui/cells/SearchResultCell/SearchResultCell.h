//
//  SearchResultCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "TableViewCell.h"

@class Recipe;

@interface SearchResultCell : TableViewCell

@property (nonatomic, strong) Recipe *item;

@end
