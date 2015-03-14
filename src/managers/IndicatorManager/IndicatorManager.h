//
//  IndicatorManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface IndicatorManager : SharedInstance

- (void)showIndicator;
- (void)showIndicatorWithTitle:(NSString *)title;
- (void)showIndicatorWithTitle:(NSString *)title userInteractionEnabled:(BOOL)userInteractionEnabled;

- (void)hideIndicator;

@end
