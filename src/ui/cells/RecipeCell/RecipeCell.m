//
//  RecipeCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipeCell.h"

#import "Haneke.h"
#import "Recipe.h"
#import "UIColor+Custom.h"

@interface RecipeCell ()

@property (nonatomic, weak) IBOutlet UIView *shadowView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titleLabelHeight;

@end

@implementation RecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor applicationBackgroundColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [[UIColor applicationDefaultColor] colorWithAlphaComponent:0.1];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView hnk_cancelSetImage];
}

- (void)setItem:(Recipe *)item {
    [super setItem:item];
    [self fillWithItem:item];
}

- (void)fillWithItem:(Recipe *)item {
    self.titleLabel.text = [NSString stringWithFormat:@"%@", (item.title ? item.title : @"")];
    [self.titleLabel sizeToFit];
    self.titleLabelHeight.constant = self.titleLabel.frame.size.height;
    
    [self.imageView hnk_setImageFromURL:[NSURL URLWithString:item.imageURL]];
    [self layoutIfNeeded];
}

@end
