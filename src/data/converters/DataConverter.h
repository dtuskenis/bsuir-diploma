//
//  DataConverter.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataConverter : NSObject

- (id)convertObjectWithObject:(id)object error:(NSError *__autoreleasing*)error;

- (void)convertObjectWithObject:(id)object
                   successBlock:(void (^)(id object))successBlock
                   failureBlock:(void (^)(NSError *)) failureBlock;

@end
