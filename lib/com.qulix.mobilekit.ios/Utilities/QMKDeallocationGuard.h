//
//  QMKDeallocationGuard.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 16.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QMKDeallocationGuard : NSObject

@property(nonatomic, copy) void(^onDealloc)(void);

+ (id)guardWithOnDeallocAction:(void(^)(void))Action;

@end
