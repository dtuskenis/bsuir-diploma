//
//  RootView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RootView.h"

#import "DrawerView.h"

@interface RootView ()

@property (nonatomic, weak) IBOutlet DrawerView *drawerView;

@property (nonatomic, strong) UIView *transitionView;

@end

@implementation RootView

- (void)performTransitionToView:(UIView *)view animated:(BOOL)animated {
    NSTimeInterval animationDuration = animated ? 0.3 : 0;
    
    if (self.transitionView != view) {
        if (self.transitionView) {
            view.frame = self.transitionView.frame;
            [UIView transitionFromView:self.transitionView
                                toView:view
                              duration:animationDuration
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            completion:^(BOOL finished) {}];
            self.transitionView = view;
        } else {
            self.transitionView = view;
            self.transitionView.frame = self.bounds;
            [self.drawerView.centerView addSubview:self.transitionView];
        }
    }
}

- (void)showMenu {
    [self.drawerView showLeftSideAnimated:YES];
}

- (void)hideMenu {
    [self.drawerView hideLeftSideAnimated:YES];
}

- (void)toggleMenu {
    [self.drawerView toggleLeftSideAnimated:YES];
}

@end
