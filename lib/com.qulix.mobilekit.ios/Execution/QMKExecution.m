//
//  QMKExecution.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecution+Protected.h"

#import "QMKSimpleInstructionStatement.h"
#import "QMKExecutionForStatement.h"
#import "QMKExecutionWhileStatement.h"
#import "QMKPriorityQueue.h"


@interface QMKExecution () {
    QMKPriorityQueue* sequence_;
}

@property(nonatomic, retain) QMKExecutionStatement* currentStatement;

@end


@implementation QMKExecution

@synthesize Do = Do_;
@synthesize Then = Then_;
@synthesize While = While_;
@synthesize For = For_;
@synthesize Finally = Finally_;

- (id)init {
    self = [super init];
    if (self) {
        Do_ = [QMKExecution newDoStatement:self];
        Then_ = [QMKExecution newThenStatement:self];
        While_ = [QMKExecution newWhileStatement:self];
        For_ = [QMKExecution newForStatement:self];
        Finally_ = [QMKExecution newFinallyStatement:self];
        
        sequence_ = [[QMKPriorityQueue alloc] init];
    }
    return self;
}

- (void)dealloc {
    [sequence_ release];
    [Do_ release];
    [Then_ release];
    [While_ release];
    [For_ release];
    [super dealloc];
}

#pragma mark -

+ (QMKExecution*(^)(void(^)(void)))newDoStatement:(QMKExecution*)self_ref {
    return [self newThenStatement:self_ref];
}

+ (QMKExecution*(^)(void(^)(void)))newThenStatement:(QMKExecution*)self_ref {
    __block QMKExecution* const self_w = self_ref;  // A weak reference to self.
    return [^(void(^Statements)(void)) {
        QMKSimpleInstructionStatement* thenStatement = [[QMKSimpleInstructionStatement alloc] initWithExecution:self_w];
        thenStatement.instructions = Statements;
        [self_w->sequence_ addObject:thenStatement priority:0.0f];
        [thenStatement release];
        return self_w;
    } copy];
}

+ (QMKExecution*(^)(int(^)(void), void(^)(void), void(^)(void)))newWhileStatement:(QMKExecution*)self_ref {
    __block QMKExecution* const self_w = self_ref;
    return [^(int(^Condition)(void), void(^Increment)(void), void(^Iteration)(void)) {
        QMKExecutionWhileStatement* whileStatement = [[QMKExecutionWhileStatement alloc] initWithExecution:self_w];
        whileStatement.Condition = Condition;
        whileStatement.Increment = Increment;
        whileStatement.Iteration = Iteration;
        [self_w->sequence_ addObject:whileStatement priority:0.0f];
        [whileStatement release];
        return self_w;
    } copy];
}

+ (QMKExecution*(^)(id<NSFastEnumeration>, void(^)(id)))newForStatement:(QMKExecution*)self_ref {
    __block QMKExecution* const self_w = self_ref;  // A weak reference to self.
    return [^(id<NSFastEnumeration> sequence, void(^Iteration)(id)) {
        QMKExecutionForStatement* statement = [[QMKExecutionForStatement alloc] initWithExecution:self_w];
        statement.sequence = sequence;
        statement.Iteration = Iteration;
        [self_w->sequence_ addObject:statement priority:0.0f];
        [statement release];
        return self_w;
    } copy];
}

+ (QMKExecution*(^)(void(^)(void)))newFinallyStatement:(QMKExecution*)self_ref {
    __block QMKExecution* const self_w = self_ref;  // A weak reference to self.
    return [^(void(^Statements)(void)) {
        QMKSimpleInstructionStatement* statement = [[QMKSimpleInstructionStatement alloc] initWithExecution:self_w];
        statement.instructions = Statements;
        [self_w->sequence_ addObject:statement priority:-1.0f];
        [statement release];
        return self_w;
    } copy];
}

- (void)continue {
    if (sequence_.count > 0) {
        if (nil == self.currentStatement) {
            self.currentStatement = [sequence_ objectAtIndex:0];
            [self.currentStatement execute];
            
        } else {
            [self.currentStatement onContinue];
        }
    }
}

- (void)onStatementDidFinish:(QMKExecutionStatement*)statement {
    [sequence_ removeObject:statement];
    self.currentStatement = nil;
    [self continue];
}

- (void)cancel {
    [sequence_ removeAllObjects];
    self.currentStatement = nil;
}

#pragma mark -

- (BOOL)isRunning {
    return (nil != self.currentStatement);
}

@end
