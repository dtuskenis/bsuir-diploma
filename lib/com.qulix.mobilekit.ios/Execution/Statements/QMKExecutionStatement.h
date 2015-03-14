//
//  QMKExecutionStatement.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QMKExecution;

/* An abstract base class for different statements of execution.
 You can override execute and onContinue methods to implement your custom statements behavior.
 */
@interface QMKExecutionStatement : NSObject

/// A reference to the parent execution sequence.
@property(nonatomic, readonly) QMKExecution* execution;

- (id)initWithExecution:(__unsafe_unretained QMKExecution*)execution;

/// Performs the desired action of this statement when the control flow gets to it. E.g. calls the client code.
/// Default implementation does nothing.
- (void)execute;

/// Called when the client code asks to continue the execution after executing this statement.
/// In this method you can notify the execution that the statement is fully finished and the control flow
/// should go to the next statement. You can do this by calling onStatementDidFinish: on the execution object.
/// Default implementation calls onStatementDidFinish:.
- (void)onContinue;

@end
