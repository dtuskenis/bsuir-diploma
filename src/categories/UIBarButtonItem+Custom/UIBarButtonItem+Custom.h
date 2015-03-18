//
//  UIBarButtonItem+Custom.h
//  Wizard
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+ (instancetype)backItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)menuItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)searchItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)commitSearchItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)favoriteButtonItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)arrowsItemWithTarget:(id)target action:(SEL)action;

@end
