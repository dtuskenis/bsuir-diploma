//
//  AlertController.m
//  ChefsBuddy
//
//  Created by Tuskenis, Denis on 5/23/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "AlertController.h"

@implementation AlertController

- (void)showAlertWithController:(UIViewController *)viewController
                          title:(NSString *)title
                        message:(NSString *)message {
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction *action) {}]];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
