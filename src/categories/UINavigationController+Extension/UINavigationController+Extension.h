//
//  UINavigationController+Extension.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/4/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)

@property (nonatomic,readonly) UIViewController *rootViewController;

- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)replaceTopViewControllerWithViewController:(UIViewController *)viewController withCustomTransition:(CATransition*(^)())transition;

- (void)pushViewController:(UIViewController *)viewController withCustomTransition:(CATransition*(^)())transition;

@end
