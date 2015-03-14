//
//  QMKPriorityQueueEntry.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 10.10.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKPriorityQueueEntry.h"


@implementation QMKPriorityQueueEntry

- (void)dealloc {
    self.object = nil;
    [super dealloc];
}

@end
