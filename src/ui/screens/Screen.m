//
//  Screen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "UIColor+Custom.h"

@interface Screen ()

@property (nonatomic, strong) ScreenManager *screenManager;

@end

@implementation Screen

- (instancetype)initWithScreenManager:(ScreenManager *)screenManager {
    self = [super init];
    if (self) {
        self.screenManager = screenManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.view setBackgroundColor:[UIColor applicationBackgroundColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
