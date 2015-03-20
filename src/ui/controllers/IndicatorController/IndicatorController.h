//
//  IndicatorController.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/20/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface IndicatorController : SharedInstance

- (void)showIndicator;
- (void)showIndicatorWithTitle:(NSString *)title;
- (void)showIndicatorWithTitle:(NSString *)title userInteractionEnabled:(BOOL)userInteractionEnabled;

- (void)hideIndicator;

@end
