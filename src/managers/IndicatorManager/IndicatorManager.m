//
//  IndicatorManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndicatorManager.h"

static NSTimeInterval kAnimationDuration = 0.23;

@interface IndicatorManager ()

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation IndicatorManager

@synthesize indicatorView = _indicatorView;

- (void)showIndicator {
    [self showIndicatorWithTitle:@"" userInteractionEnabled:NO];
}

- (void)showIndicatorWithTitle:(NSString *)title {
    [self showIndicatorWithTitle:title userInteractionEnabled:NO];
}

- (void)showIndicatorWithTitle:(NSString *)title userInteractionEnabled:(BOOL)userInteractionEnabled {
    if (self.indicatorView.superview == nil) {
        self.indicatorView.userInteractionEnabled = !userInteractionEnabled;
        self.indicatorView.alpha = 0;
        [[self window] addSubview:self.indicatorView];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.indicatorView.alpha = 1;
        } completion:^(BOOL finished) {}];
    }
}

- (void)hideIndicator {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.indicatorView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.indicatorView removeFromSuperview];
    }];
}

- (UIWindow *)window {
    return [[UIApplication sharedApplication] windows].firstObject;
}

- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _indicatorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return _indicatorView;
}

@end
