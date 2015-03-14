//
//  QMKInvocationFork.m
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 29.08.12.
//  Copyright (c) 2012 Qulix Systems. All rights reserved.
//

#import "QMKInvocationFork.h"

#import <objc/runtime.h>
#import "QMKWeakSet.h"


typedef struct qmk_protocol_method_description {
    struct objc_method_description method;
    BOOL isRequired;
} qmk_protocol_method_description;

struct qmk_protocol_method_description qmk_protocol_getMethodDescription(Protocol* protocol, SEL selector);
BOOL qmk_object_respondsToSelector(id object, SEL selector);

struct qmk_protocol_method_description qmk_protocol_getMethodDescription(Protocol* protocol, SEL selector) {
    qmk_protocol_method_description description;
    description.method = protocol_getMethodDescription(protocol, selector, YES, YES);
    description.isRequired = YES;
    
    if (NULL == description.method.name) {
        description.method = protocol_getMethodDescription(protocol, selector, NO, YES);
        description.isRequired = NO;
    }
    
    return description;
}

BOOL qmk_object_respondsToSelector(id object, SEL selector) {
    Class class = object_getClass(object);
    BOOL doesRespond = NO;
    if (class_respondsToSelector(class, @selector(respondsToSelector:))) {
        doesRespond = [object respondsToSelector:selector];
        
    } else {
        doesRespond = class_respondsToSelector(class, selector);
    }
    return doesRespond;
}


@interface QMKInvocationFork () {
    Protocol* protocol_;
    QMKWeakSet* responders_;
}

@end


@implementation QMKInvocationFork

- (id)initWithProtocol:(Protocol*)protocol {
    self = [super init];
    if (self) {
        protocol_ = protocol;
        responders_ = [[QMKWeakSet alloc] init];
    }
    return self;
}

- (void)dealloc {
    [responders_ release];
    [super dealloc];
}

#pragma mark -

- (void)addResponder:(id)responder {
    [responders_ addObject:responder];
}

- (void)removeResponder:(id)responder {
    [responders_ removeObject:responder];
}

#pragma mark -

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL doesRespond = NO;
    qmk_protocol_method_description description = qmk_protocol_getMethodDescription(protocol_, aSelector);
    if (NULL != description.method.name) {
        for (id responder in responders_) {
            doesRespond = qmk_object_respondsToSelector(responder, aSelector);
            if (doesRespond) {
                break;
            }
        }
    }
    return doesRespond;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
    qmk_protocol_method_description description = qmk_protocol_getMethodDescription(protocol_, selector);
    NSMethodSignature* signature = nil;
    if (NULL != description.method.name) {
        signature = [NSMethodSignature signatureWithObjCTypes:description.method.types];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    qmk_protocol_method_description description = qmk_protocol_getMethodDescription(protocol_, selector);
    for (id responder in responders_) {
        if (description.isRequired || qmk_object_respondsToSelector(responder, selector)) {
            [anInvocation invokeWithTarget:responder];
        }
    }
}

@end
