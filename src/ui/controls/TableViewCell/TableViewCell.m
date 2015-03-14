//
//  TableViewCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)setItem:(id)item {
    _item = item;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:[self cellIdentifier] bundle:nil];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}

@end
