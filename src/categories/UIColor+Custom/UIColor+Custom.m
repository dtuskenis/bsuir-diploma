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
}

+ (instancetype)applicationBackgroundColor {
    return [UIColor colorWithRed:(float)205 / 255
                           green:(float)215 / 255
                            blue:(float)240 / 255
                           alpha:1.000];
}

+ (instancetype)applicationTintColor {
    return [UIColor whiteColor];
}

@end
