//
//  MenuView.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;

- (void)addItemWithTitle:(NSString *)title icon:(UIImage *)icon action:(void (^)())action;

@end
