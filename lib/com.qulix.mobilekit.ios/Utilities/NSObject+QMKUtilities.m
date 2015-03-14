//
//  NSObject+QMKUtilities.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 16.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "NSObject+QMKUtilities.h"

#import <objc/runtime.h>
#import "QMKDeallocationGuard.h"


@implementation NSObject (QMKUtilities)

- (void*)qmk_onDealloc:(void(^)(void))Action {
    return QMKAddOnDeallocAction(self, Action);
}

- (void)qmk_removeOnDeallocAction:(void*)actionKey {
    QMKRemoveOnDeallocAction(self, actionKey);
}

@end


void* QMKAddOnDeallocAction(id object, void(^onDealloc)(void)) {
    QMKDeallocationGuard* guard = [[QMKDeallocationGuard alloc] init];
    guard.onDealloc = onDealloc;
    void* associationKey = guard;
    objc_setAssociatedObject(object, associationKey, guard, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [guard release];
    return associationKey;
}

void QMKRemoveOnDeallocAction(id object, void* actionKey) {
    QMKDeallocationGuard* guard = (QMKDeallocationGuard*)actionKey;
    guard.onDealloc = nil;
    objc_setAssociatedObject(object, actionKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}