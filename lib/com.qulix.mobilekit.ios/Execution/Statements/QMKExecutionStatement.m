//
//  QMKExecutionStatement.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionStatement.h"

#import "QMKExecution+Protected.h"


@implementation QMKExecutionStatement

@synthesize execution = execution_;

- (id)initWithExecution:(__unsafe_unretained QMKExecution*)execution {
    self = [super init];
    if (self) {
        execution_ = execution;
    }
    return self;
}

#pragma mark -

- (void)execute {
    // default implementation:
    // do nothing
}

- (void)onContinue {
    // default implementation:
    [self.execution onStatementDidFinish:self];
}

@end
