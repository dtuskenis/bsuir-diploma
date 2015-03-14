//
//  QMKSimpleInstructionStatement.m
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 07.09.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import "QMKSimpleInstructionStatement.h"


@implementation QMKSimpleInstructionStatement

- (void)dealloc {
    self.instructions = NULL;
    [super dealloc];
}

#pragma mark -

- (void)execute {
    self.instructions();
}

@end
