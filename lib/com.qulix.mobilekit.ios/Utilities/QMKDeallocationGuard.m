//
//  QMKDeallocationGuard.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 16.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKDeallocationGuard.h"


@implementation QMKDeallocationGuard

@synthesize onDealloc = onDealloc_;

+ (id)guardWithOnDeallocAction:(void(^)(void))onDealloc {
    QMKDeallocationGuard* guard = [[[self alloc] init] autorelease];
    guard.onDealloc = onDealloc;
    return guard;
}

- (void)dealloc {
    if (onDealloc_) {
        onDealloc_();
    }
    [super dealloc];
}

@end
