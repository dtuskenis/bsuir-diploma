//
//  FavoriteButton.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "FavoriteButton.h"

@implementation FavoriteButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 44, 44);
        [self setImage:[[UIImage imageNamed:@"icon_favorite_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              forState:UIControlStateNormal];
        [self setImage:[[UIImage imageNamed:@"icon_favorite_yes"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              forState:UIControlStateSelected];
        self.tintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeTouches) {
        self.selected = !self.selected;
    }
    
    [super sendAction:action to:target forEvent:event];
}

@end
