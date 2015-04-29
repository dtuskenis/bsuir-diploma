//
//  MenuViewCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/13/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "MenuViewCell.h"

#import "MenuViewItem.h"
#import "UIColor+Custom.h"

@interface MenuViewCell ()

@property (nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation MenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.button setTitleColor:[UIColor applicationDefaultColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [[UIColor applicationDefaultColor] colorWithAlphaComponent:1];
}

- (void)setItem:(MenuViewItem *)item {
    [super setItem:item];
    [self fillWithItem:item];
}

- (void)fillWithItem:(MenuViewItem *)item {
    [self.button setTitle:item.title forState:UIControlStateNormal];
    [self.button setImage:[item.icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    
    self.contentView.backgroundColor = checked ? self.selectedBackgroundView.backgroundColor : [UIColor clearColor];
    self.button.selected = checked;
    self.button.tintColor = (checked ? [UIColor whiteColor] : [UIColor applicationDefaultColor]);
}

@end
