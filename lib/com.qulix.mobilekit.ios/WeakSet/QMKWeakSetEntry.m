//
//  QMKWeakSetEntry.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 19.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKWeakSetEntry.h"

@implementation QMKWeakSetEntry

- (id)initWithObject:(id)object {
    self = [super init];
    if (self) {
        object_ = object;
    }
    return self;
}

#pragma mark -

- (BOOL)isEqual:(id)other {
    return ([self class] == [other class] && ((QMKWeakSetEntry*)other)->object_ == self->object_);
}

- (NSUInteger)hash {
    return (NSUInteger)object_;
}

@end
