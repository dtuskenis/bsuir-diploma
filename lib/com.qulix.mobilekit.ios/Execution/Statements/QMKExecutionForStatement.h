//
//  QMKExecutionForStatement.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 12.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionStatement.h"


@interface QMKExecutionForStatement : QMKExecutionStatement

@property(nonatomic, retain) id<NSFastEnumeration> sequence;
@property(nonatomic, copy) void(^Iteration)(id);

@end
