//
//  UINavigationController+Extension.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/4/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (UIViewController *)rootViewController {
    return self.viewControllers.firstObject;
}

- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    [viewControllers removeLastObject];
    [viewControllers addObject:viewController];
    [self setViewControllers:viewControllers animated:animated];
}

- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController withCustomTransition:(CATransition*(^)())transition {
    if (transition) {
        [self.view.layer addAnimation:transition() forKey:kCATransition];
    }
    [self replaceTopViewControllerWithViewController:viewController animated:NO];
}

- (void)pushViewController:(UIViewController *)viewController withCustomTransition:(CATransition*(^)())transition {
    if (transition) {
        [self.view.layer addAnimation:transition() forKey:kCATransition];
    }
    [self pushViewController:viewController animated:NO];
}

@end
