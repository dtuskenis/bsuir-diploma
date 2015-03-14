//
//  QMKPriorityQueueEntry.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 10.10.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QMKPriorityQueueEntry : NSObject

@property(nonatomic, retain) id object;
@property(nonatomic, assign) float priority;

@end
