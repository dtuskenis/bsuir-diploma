//
//  TableViewCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) id item;

+ (NSString *)cellIdentifier;
+ (UINib *)cellNib;

@end
