//
//  Screen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Screen.h"

#import "AlertController.h"
#import "UIBarButtonItem+Custom.h"
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
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1;
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)backButtonTouched:(id)sender {
    [self.screenManager goBack];
}

- (void)handleError:(NSError *)error {
    if ([error.domain isEqual:NSURLErrorDomain]) {
        [[AlertController sharedInstance] showAlertWithController:self title:@"Error" message:@"Internet connection appears to be offline."];
    }
}

@end
