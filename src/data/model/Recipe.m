//
//  Recipe.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (BOOL)isEqual:(Recipe *)otherRecipe {
    return [self.identifier isEqualToString:otherRecipe.identifier];
}

@end
