//
//  DrawerView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/6/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "DrawerView.h"

#import "Masonry.h"

@interface DrawerView ()

@property (nonatomic, assign) CGFloat leftSideWidth;
@property (nonatomic, strong) UIView *fadeView;

@end

@implementation DrawerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftSideWidth = 240;
    
    self.centerView.frame = self.bounds;
    [self addSubview:self.centerView];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.fadeView = [[UIView alloc] initWithFrame:self.bounds];
    self.fadeView.userInteractionEnabled = NO;
    self.fadeView.backgroundColor = [UIColor clearColor];
    [self.fadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleLeftSideAnimated)]];
    [self addSubview:self.fadeView];
    
    [self.fadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.leftView.frame = CGRectMake(-self.leftSideWidth, 0, self.leftSideWidth, self.bounds.size.height);
    [self addSubview:self.leftView];
}

- (void)showLeftSideAnimated:(BOOL)animated {
    NSTimeInterval animationDuration = animated ? 0.3 : 0;
    
    self.fadeView.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        self.fadeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.leftView.frame = self.leftView.frame = CGRectMake(0, 0, self.leftSideWidth, self.bounds.size.height);
    } completion:^(BOOL finished) {}];
}

- (void)hideLeftSideAnimated:(BOOL)animated {
    NSTimeInterval animationDuration = animated ? 0.3 : 0;
    
    self.fadeView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        self.fadeView.backgroundColor = [UIColor clearColor];
        self.leftView.frame = self.leftView.frame = CGRectMake(-self.leftSideWidth, 0, self.leftSideWidth, self.bounds.size.height);
    } completion:^(BOOL finished) {}];
}

- (void)toggleLeftSideAnimated {
    [self toggleLeftSideAnimated:YES];
}

- (void)toggleLeftSideAnimated:(BOOL)animated {
    NSTimeInterval animationDuration = animated ? 0.3 : 0;
    
    self.fadeView.userInteractionEnabled = !self.fadeView.userInteractionEnabled;
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        self.fadeView.backgroundColor = [self.fadeView.backgroundColor isEqual:[UIColor clearColor]] ? [[UIColor blackColor] colorWithAlphaComponent:0.8] : [UIColor clearColor];
        
        CGFloat x = (self.leftView.frame.origin.x == 0) ? -self.leftSideWidth : 0;
        self.leftView.frame = self.leftView.frame = CGRectMake(x, 0, self.leftSideWidth, self.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

@end
