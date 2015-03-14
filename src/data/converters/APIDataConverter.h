//
//  APIDataConverter.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APIRecipe;
@class APIRecipeBrief;
@class APISearchRequest;
@class APISearchResult;
@class Recipe;
@class SearchRequest;

@interface APIDataConverter : NSObject

+ (APISearchRequest *)APISearchRequestWithSearchRequest:(SearchRequest *)searchRequest APIKey:(NSString *)APIKey;

+ (NSArray *)searchResultsWithAPISearchResult:(APISearchResult *)searchResult;
+ (Recipe *)recipeWithAPIRecipe:(APIRecipe *)recipe;
+ (Recipe *)recipeWithAPIRecipeBrief:(APIRecipeBrief *)recipeBrief;

@end
