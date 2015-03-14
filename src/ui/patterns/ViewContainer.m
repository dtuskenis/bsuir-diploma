//
//  ViewContainer.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ViewContainer.h"

#import "UIView+Nib.h"

@implementation ViewContainer

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *viewClassName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Container" withString:@""];
        UIView *view = [NSClassFromString(viewClassName) viewFromNib];
        view.frame = self.bounds;
        [self addSubview:view];
        self.view = view;
    }
    return self;
}

@end
