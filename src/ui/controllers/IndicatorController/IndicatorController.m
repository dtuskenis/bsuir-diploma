//
//  IndicatorController.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/20/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "IndicatorController.h"

#import "IndicatorView.h"
#import "UIView+Nib.h"

static NSTimeInterval kAnimationDuration = 0.23;

@interface IndicatorController ()

@property (nonatomic, strong) IndicatorView *indicatorView;

@end

@implementation IndicatorController

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
        self.indicatorView.frame = [self window].bounds;
        [[self window] addSubview:self.indicatorView];
        self.indicatorView.title = title;
        
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
        _indicatorView = [IndicatorView viewFromNib];
    }
    return _indicatorView;
}

@end
