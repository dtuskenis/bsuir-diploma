//
//  QMKExecution+Protected.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecution.h"

@class QMKExecutionStatement;


@interface QMKExecution (Protected)

/// Should be called by the current statement when it is done.
- (void)onStatementDidFinish:(QMKExecutionStatement*)statement;

@end
