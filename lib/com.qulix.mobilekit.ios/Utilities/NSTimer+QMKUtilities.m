//
//  NSTimer+QMKUtilities.m
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 29.07.11.
//  Copyright (c) 2011 Qulix Systems. All rights reserved.
//

#import "NSTimer+QMKUtilities.h"


@interface NSInvocation (QMKUtilities_Timer)

- (void)qmk_invokeAsHandlerForTimer:(NSTimer*)timer;

@end


@implementation NSTimer (QMKUtilities)

+ (NSTimer*)qmk_weakScheduledTimerWithTimeInterval:(NSTimeInterval)seconds invocation:(NSInvocation *)invocation userInfo:(id)userInfo repeats:(BOOL)repeats {
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                      target:invocation
                                                    selector:@selector(qmk_invokeAsHandlerForTimer:)
                                                    userInfo:userInfo
                                                     repeats:repeats];
    return timer;
}

+ (NSTimer *)qmk_weakScheduledTimerWithTimeInterval:(NSTimeInterval)seconds invocation:(NSInvocation *)invocation repeats:(BOOL)repeats {
    return [self qmk_weakScheduledTimerWithTimeInterval:seconds invocation:invocation userInfo:nil repeats:repeats];
}

+ (NSTimer *)qmk_weakScheduledTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats {
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:aSelector]];
    [invocation setSelector:aSelector];
    [invocation setTarget:target];
    return [self qmk_weakScheduledTimerWithTimeInterval:seconds invocation:invocation userInfo:userInfo repeats:repeats];
}

@end


@implementation NSInvocation (QMKUtilities_Timer)

- (void)qmk_invokeAsHandlerForTimer:(NSTimer*)timer {
    [self setArgument:&timer atIndex:2];
    [self invoke];
}

@end
