//
//  IndicatorView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/20/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "IndicatorView.h"

@interface IndicatorView ()

@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titleLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titleLabelWidth;

@end

@implementation IndicatorView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view.layer.cornerRadius = 8.0;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
    [self.titleLabel sizeToFit];
    self.titleLabelHeight.constant = self.titleLabel.frame.size.height;
    self.titleLabelWidth.constant = self.titleLabel.frame.size.width;
    [self layoutIfNeeded];
}

@end
