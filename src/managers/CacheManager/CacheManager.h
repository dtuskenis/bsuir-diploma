//
//  CacheManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/6/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface CacheManager : SharedInstance

- (void)objectForKey:(NSString *)key recieveBlock:(void (^)(id object))recieveBlock;
- (void)cacheObject:(id<NSCoding>)object forKey:(NSString *)key completionBlock:(void (^)())completionBlock;

@end
