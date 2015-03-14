//
//  QMKExecutionForStatement.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 12.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKExecutionForStatement.h"

#import "QMKExecution+Protected.h"


@implementation QMKExecutionForStatement {
    NSFastEnumerationState state_;
    id* defaultBuffer_;
    NSInteger bufferSize_;
    NSInteger index_;
}

- (id)initWithExecution:(QMKExecution *)execution {
    self = [super initWithExecution:execution];
    if (self) {
        defaultBuffer_ = malloc(sizeof(id));
    }
    return self;
}

- (void)dealloc {
    free(defaultBuffer_);
    defaultBuffer_ = NULL;
    self.sequence = nil;
    self.Iteration = NULL;
    [super dealloc];
}

#pragma mark -

- (void)execute {
    if (index_ >= bufferSize_) {
        bufferSize_ = [self.sequence countByEnumeratingWithState:&state_ objects:defaultBuffer_ count:1];
        index_ = 0;
    }
    
    if (bufferSize_ > 0) {
        id object = state_.itemsPtr[index_];
        self.Iteration(object);
        
    } else {
        [self.execution onStatementDidFinish:self];
    }
}

- (void)onContinue {
    ++index_;
    [self execute];
}

@end
