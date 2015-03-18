//
//  UIBarButtonItem+Custom.m
//  Wizard
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

#import "UIColor+Custom.h"

@implementation UIBarButtonItem (Custom)

+ (instancetype)backItemWithTarget:(id)target action:(SEL)action {
    return [[self class] itemWithImage:[UIImage imageNamed:@"icon_back_button"] target:target action:action];
}

+ (instancetype)menuItemWithTarget:(id)target action:(SEL)action {
    return [[self class] itemWithImage:[UIImage imageNamed:@"icon_menu"] target:target action:action];
}

+ (instancetype)searchItemWithTarget:(id)target action:(SEL)action {
    return [[self class] itemWithImage:[UIImage imageNamed:@"icon_search"] target:target action:action];
}

+ (instancetype)commitSearchItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(2, 0, 0, -2)];
    [button setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)arrowsItemWithTarget:(id)target action:(SEL)action {
    return [self itemWithImage:[UIImage imageNamed:@"icon_arrows"] target:target action:action];
}

+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action];
    
    item.tintColor = [UIColor applicationTintColor];
    
    return item;
}

@end
