//
//  AlertManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/31/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface AlertManager : SharedInstance

- (void)showError:(NSError *)error;

@end
