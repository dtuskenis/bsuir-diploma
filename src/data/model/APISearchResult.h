//
//  APISearchResult.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@protocol APIRecipeBrief
@end

@interface APISearchResult : JSONModel

@property (nonatomic, assign) NSInteger resultsCount;
@property (nonatomic, strong) NSArray<APIRecipeBrief> *results;

@end
