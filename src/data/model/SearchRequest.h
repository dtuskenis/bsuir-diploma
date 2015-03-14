//
//  SearchRequest.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchRequest : NSObject

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *keywords;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, assign) NSRange searchRange;

@end
