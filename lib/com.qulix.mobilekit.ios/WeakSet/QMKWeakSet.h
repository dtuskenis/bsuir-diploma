//
//  QMKWeakSet.h
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 26.03.12.
//  Copyright (c) 2012 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Contains a set of weak references to objects.
/// Features:
/// * The objects are not retained by the container.
/// * The references to deallocated objects are automatically removed from the container.
/// * It is valid to mutate the container during enumeration.
@interface QMKWeakSet : NSObject<NSFastEnumeration>

/// The number of references contained.
- (NSInteger)count;

/// Adds to the container a weak reference to the given object. Duplicates are filtered out.
- (void)addObject:(id)object;

/// Removes from the container the reference to the given object.
- (void)removeObject:(id)object;

/// Returns YES if a given object is present in the container.
- (BOOL)containsObject:(id)object;

@end
