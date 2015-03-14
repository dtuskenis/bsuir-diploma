//
//  QMKPriorityQueue.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 10.10.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QMKPriorityQueue : NSObject

- (void)addObject:(id)object priority:(float)priority;
- (void)removeObject:(id)object;
- (void)removeAllObjects;

- (NSInteger)count;
- (id)objectAtIndex:(NSInteger)index;

@end
