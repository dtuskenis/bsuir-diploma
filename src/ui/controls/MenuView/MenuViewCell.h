//
//  MenuViewCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/13/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "TableViewCell.h"

@class MenuViewItem;

@interface MenuViewCell : TableViewCell

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, strong) MenuViewItem *item;

@end
