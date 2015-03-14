//
//  QMKExecutionWhileStatement.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionWhileStatement.h"

#import "QMKExecution+Protected.h"


@implementation QMKExecutionWhileStatement

- (void)dealloc {
    self.Condition = NULL;
    self.Increment = NULL;
    self.Iteration = NULL;
    [super dealloc];
}

#pragma mark -

- (void)execute {
    if (self.Condition()) {
        self.Iteration();
        
    } else {
        [self.execution onStatementDidFinish:self];
    }
}

- (void)onContinue {
    self.Increment();
    [self execute];
}

@end
