//
//  AlertController.h
//  ChefsBuddy
//
//  Created by Tuskenis, Denis on 5/23/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface AlertController : SharedInstance

- (void)showAlertWithController:(UIViewController *)viewController
                          title:(NSString *)title
                        message:(NSString *)message;

@end
