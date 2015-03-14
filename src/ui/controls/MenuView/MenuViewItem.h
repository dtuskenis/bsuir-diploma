//
//  MenuViewItem.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) void (^action)();

@end
