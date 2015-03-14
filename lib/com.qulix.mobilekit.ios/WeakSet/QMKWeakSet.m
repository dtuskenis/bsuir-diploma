//
//  QMKWeakSet.m
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 26.03.12.
//  Copyright (c) 2012 Qulix Systems. All rights reserved.
//

#import "QMKWeakSet.h"

#import "NSObject+QMKUtilities.h"
#import "QMKWeakSetEntry.h"


@interface QMKWeakSet () {
    NSMutableSet* referencesSet_;
}

@end


@implementation QMKWeakSet

- (id)init {
    self = [super init];
    if (self) {
        referencesSet_ = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)dealloc {
    for (QMKWeakSetEntry* entry in referencesSet_) {
        [self cleanupEntry:entry];
    }
    [referencesSet_ release];
    [super dealloc];
}

#pragma mark -

- (NSInteger)count {
    return [referencesSet_ count];
}

- (void)addObject:(id)object {
    QMKWeakSetEntry* ref = [[QMKWeakSetEntry alloc] initWithObject:object];
    if (![referencesSet_ containsObject:ref]) {
        __block QMKWeakSet* self_w = self;
        __block id object_w = object;
        ref->deallocActionKey_ = QMKAddOnDeallocAction(object_w, ^{
            [self_w removeObject:object_w];
        });
        
        [referencesSet_ addObject:ref];
    }
    [ref release];
}

- (void)removeObject:(id)object {
    QMKWeakSetEntry* ref = [[QMKWeakSetEntry alloc] initWithObject:object];
    QMKWeakSetEntry* entry = [referencesSet_ member:ref];
    if (entry) {
        [self cleanupEntry:entry];
        [referencesSet_ removeObject:entry];
    }
    
    [ref release];
}

- (BOOL)containsObject:(id)object {
    QMKWeakSetEntry* ref = [[QMKWeakSetEntry alloc] initWithObject:object];
    BOOL doesContain = [referencesSet_ containsObject:ref];
    [ref release];
    return doesContain;
}

#pragma mark -

- (void)cleanupEntry:(QMKWeakSetEntry*)entry {
    QMKRemoveOnDeallocAction(entry->object_, entry->deallocActionKey_);
}

#pragma mark -

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
    if (0 == state->state) {
        NSSet* buffer = [NSSet setWithSet:referencesSet_];
        state->state = (unsigned long)[buffer objectEnumerator];
    }
    
    NSEnumerator* enumerator = (NSEnumerator*)state->state;
    NSInteger count = 0;
    if (len > 0) {
        QMKWeakSetEntry* entry = nil;
        while ((entry = [enumerator nextObject])) {
            if ([referencesSet_ containsObject:entry]) {
                stackbuf[count] = entry->object_;
                ++count;
                break;
            }
        }
    }
    state->itemsPtr = stackbuf;
    state->mutationsPtr = (unsigned long*)self;
    return count;
}

@end
