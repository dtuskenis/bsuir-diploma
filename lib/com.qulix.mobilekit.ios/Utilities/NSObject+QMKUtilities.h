//
//  NSObject+QMKUtilities.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 16.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (QMKUtilities)

- (void*)qmk_onDealloc:(void(^)(void))Action;
- (void)qmk_removeOnDeallocAction:(void*)actionKey;

@end


void* QMKAddOnDeallocAction(id object, void(^onDealloc)(void));
void QMKRemoveOnDeallocAction(id object, void* actionKey);
