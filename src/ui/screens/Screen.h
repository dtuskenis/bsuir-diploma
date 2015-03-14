//
//  Screen.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScreenManager.h"

@interface Screen : UIViewController

@property (nonatomic, readonly) ScreenManager *screenManager;

- (instancetype)initWithScreenManager:(ScreenManager *)screenManager;

@end
