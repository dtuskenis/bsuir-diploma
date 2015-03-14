//
//  QMKExecution.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


/** Allows to represent a sequence of statements in a continuation-passing style.
 
 The core pattern is to build a set of tasks each of which determine when the next task is allowed to continue.
 You can add statements to the execution using constructions like Do or Then as in the example below.
 The statements will be executed in the same order as they were added to the execution.
 
 The execution object will reset to its original state when all the statements complete or the execution is cancelled.
 You'll have to build the sequence of statements again after that.
 
 Example usage:
    QMKExecution* execution = [[QMKExecution alloc] init];
    execution.Do(^{
        // Some statements to execute.
        [execution continue];
 
    }).Then(^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // You can do some asynchronous work.
            [execution continue];  // Don't forget to call continue when your task completes.
        }
    });
    __block int counter = 0;
    execution.While(^{ return counter < 10; }, ^{
        // Asynchronously count from 0 through 9.
        dispatch_async(dispatch_get_main_queue(), ^{
            ++counter;
            [execution continue];  // Call continue to go to the next iteration of the cycle.
        }
    });
    [execution continue];  // Call continue the first time to launch the sequence.
 
 */
@interface QMKExecution : NSObject

@property(nonatomic, readonly) QMKExecution*(^Do)(void(^Statements)(void));
@property(nonatomic, readonly) QMKExecution*(^Then)(void(^Statements)(void));
@property(nonatomic, readonly) QMKExecution*(^While)(int(^Condition)(void), void(^Increment)(void), void(^Iteration)(void));
@property(nonatomic, readonly) QMKExecution*(^For)(id<NSFastEnumeration> sequence, void(^Iteration)(id object));

@property(nonatomic, readonly) QMKExecution*(^Finally)(void(^Statements)(void));

@property(nonatomic, readonly) BOOL isRunning;

/// Allows the control flow to to go the next statement or continue the execution of the current one.
/// The actual behavior depends on the current statement being executed. E.g. the While statement performs
/// another iteration of the loop if the specified condition is true.
- (void)continue;

/// Cancels the execution and drops all the remained statements.
- (void)cancel;

@end
