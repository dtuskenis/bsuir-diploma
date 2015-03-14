//
//  UIView+Nib.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

+ (instancetype)viewFromNib {
    id view = nil;
    NSArray *nibContent = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    for (id object in nibContent) {
        if ([object isKindOfClass:[self class]]) {
            view = object;
            break;
        }
    }
    
    return view;
}

@end
