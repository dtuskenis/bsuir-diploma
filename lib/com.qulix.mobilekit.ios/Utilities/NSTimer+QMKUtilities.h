//
//  NSTimer+QMKUtilities.m
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 29.07.11.
//  Copyright (c) 2011 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSTimer (QMKUtilities)

/// Returns a scheduled timer which doesn't requires the given invocation to retain its arguments.
+ (NSTimer *)qmk_weakScheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                         invocation:(NSInvocation *)invocation
                                            repeats:(BOOL)repeats;

/// Returns a scheduled timer which doesn't hold a strong reference to its target, i.e. doesn't retains it.
+ (NSTimer *)qmk_weakScheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                             target:(id)target
                                           selector:(SEL)aSelector
                                           userInfo:(id)userInfo
                                            repeats:(BOOL)repeats;

@end
