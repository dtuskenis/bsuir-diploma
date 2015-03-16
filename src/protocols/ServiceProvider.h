//
//  ServiceProvider.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/16/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceProvider <NSObject>

- (id)getServiceWithClass:(Class)serviceClass;

- (void)registerService:(id)service withClass:(Class)serviceClass;

@end
