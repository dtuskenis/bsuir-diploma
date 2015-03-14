//
//  SharedInstance.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"
#import <objc/objc-sync.h>

@implementation SharedInstance

+ (instancetype)sharedInstance {
    static NSMutableDictionary *sharedInstances = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstances = [NSMutableDictionary dictionary];
    });
    
    objc_sync_enter(self);
    id instance = [sharedInstances objectForKey:NSStringFromClass([self class])];
    if (instance == nil) {
        instance = [[[self class] alloc] init];
        [sharedInstances setObject:instance forKey:NSStringFromClass([self class])];
    }
    objc_sync_exit(self);
    
    return instance;
}

@end
