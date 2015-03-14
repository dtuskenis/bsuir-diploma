//
//  UIColor+Custom.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (instancetype)applicationDefaultColor {
    return [UIColor colorWithRed:0.420 green:0.522 blue:0.784 alpha:1.000];
    /*
    return [UIColor colorWithRed:193.0 / 255
                           green:69.0 / 255
                            blue:63.0 / 255
                           alpha:1.0];
     */
}

+ (instancetype)applicationBackgroundColor {
    return [UIColor colorWithRed:0.804 green:0.843 blue:0.941 alpha:1.000];
    /*
    return [UIColor colorWithRed:244.0 / 255
                           green:241.0 / 255
                            blue:215.0 / 255
                           alpha:1.0];
     */
}

+ (instancetype)applicationTintColor {
    return [UIColor whiteColor];
}

@end
