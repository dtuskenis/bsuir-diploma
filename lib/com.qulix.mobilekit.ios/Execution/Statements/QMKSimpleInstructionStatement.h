//
//  QMKSimpleInstructionStatement.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionStatement.h"

/// A statement of execution representing a simple block of code to be executed once.
@interface QMKSimpleInstructionStatement : QMKExecutionStatement

@property(nonatomic, copy) void(^instructions)(void);

@end
