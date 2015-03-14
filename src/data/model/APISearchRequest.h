//
//  APISearchRequest.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "JSONModel.h"

@interface APISearchRequest : JSONModel

@property (nonatomic, strong) NSString *api_key;
@property (nonatomic, strong) NSString *title_kw;
@property (nonatomic, strong) NSString<Optional> *any_kw;
@property (nonatomic, strong) NSArray<Optional> *include_primarycat;
@property (nonatomic, strong) NSArray<Optional> *cuisine;
@property (nonatomic, strong) NSArray<Optional> *include_ing;
@property (nonatomic, strong) NSArray<Optional> *exclude_ing;
@property (nonatomic, assign) NSUInteger pg;
@property (nonatomic, assign) NSUInteger rpp;

@end
