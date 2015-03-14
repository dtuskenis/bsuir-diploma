//
//  Model.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Model.h"

#import "NSObject+NSCoding.h"

@implementation Model

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self autoDecode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self autoEncodeWithCoder:aCoder];
}


@end
