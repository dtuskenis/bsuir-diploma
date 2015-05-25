//
//  UINavigationItem+Custom.m
//  ChefsBuddy
//
//  Created by Tuskenis, Denis on 5/25/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "UINavigationItem+Custom.h"

#import "UIColor+Custom.h"

@implementation UINavigationItem (Custom)

- (void)setCustomTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor applicationTintColor]];
    [titleLabel sizeToFit];
    [self setTitleView:titleLabel];
}

- (NSString *)customTitle {
    if ([self.titleView isKindOfClass:[UILabel class]]) {
        return [(UILabel *)self.titleView text];
    } else {
        return nil;
    }
}

@end
