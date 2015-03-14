//
//  QMKPriorityQueue.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 10.10.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKPriorityQueue.h"

#import "QMKPriorityQueueEntry.h"


@interface QMKPriorityQueue() {
    NSMutableArray* queue_;
}

@end


@implementation QMKPriorityQueue

- (id)init {
    self = [super init];
    if (self) {
        queue_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [queue_ release];
    [super dealloc];
}

#pragma mark -

- (void)addObject:(id)object priority:(float)priority {
    QMKPriorityQueueEntry* entry = [[QMKPriorityQueueEntry alloc] init];
    entry.object = object;
    entry.priority = priority;
    
    NSInteger insertionIndex = [queue_ indexOfObject:entry
                                       inSortedRange:NSMakeRange(0, queue_.count)
                                             options:(NSBinarySearchingInsertionIndex | NSBinarySearchingLastEqual)
                                     usingComparator:^NSComparisonResult(QMKPriorityQueueEntry* entry1, QMKPriorityQueueEntry* entry2) {
                                         float p1 = entry1.priority;
                                         float p2 = entry2.priority;
                                         return (p1 > p2 ? NSOrderedAscending : (p1 < p2 ? NSOrderedDescending : NSOrderedSame));
                                     }];
    [queue_ insertObject:entry atIndex:insertionIndex];
    
    [entry release];
}

- (void)removeObject:(id)object {
    NSInteger index = [queue_ indexOfObjectPassingTest:^BOOL(QMKPriorityQueueEntry* entry, NSUInteger idx, BOOL *stop) {
        return (entry.object == object);
    }];
    [queue_ removeObjectAtIndex:index];
}

- (void)removeAllObjects {
    [queue_ removeAllObjects];
}

- (NSInteger)count {
    return queue_.count;
}

- (id)objectAtIndex:(NSInteger)index {
    return [[queue_ objectAtIndex:index] object];
}

@end
