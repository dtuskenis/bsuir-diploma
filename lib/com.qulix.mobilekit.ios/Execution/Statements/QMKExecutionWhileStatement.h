//
//  QMKExecutionWhileStatement.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionStatement.h"


@interface QMKExecutionWhileStatement : QMKExecutionStatement

@property(nonatomic, copy) int(^Condition)(void);
@property(nonatomic, copy) void(^Increment)(void);
@property(nonatomic, copy) void(^Iteration)(void);

@end
