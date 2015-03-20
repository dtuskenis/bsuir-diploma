//
//  APIDataConverter.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "APIDataConverter.h"

#import "APIModel.h"
#import "Ingredient.h"
#import "Recipe.h"
#import "SearchRequest.h"

@implementation APIDataConverter

+ (APISearchRequest *)APISearchRequestWithSearchRequest:(SearchRequest *)request APIKey:(NSString *)APIKey {
    APISearchRequest *searchRequest = [[APISearchRequest alloc] init];
    searchRequest.title_kw = [request.keywords componentsJoinedByString:@" "];
    searchRequest.include_primarycat = request.categories;
    searchRequest.pg = 1 + (int)((request.searchRange.location + request.searchRange.length) / 50);
    searchRequest.rpp = ((request.searchRange.location + request.searchRange.length) - (searchRequest.pg - 1) * 50);
    searchRequest.api_key = APIKey;
    return searchRequest;
}

+ (NSArray *)searchResultsWithAPISearchResult:(APISearchResult *)searchResult {
    NSMutableArray *searchResults = [NSMutableArray array];
    
    for (APIRecipeBrief *recipeBrief in searchResult.results) {
        [searchResults addObject:[self recipeWithAPIRecipeBrief:recipeBrief]];
    }
    
    return [NSArray arrayWithArray:searchResults];
}

+ (Recipe *)recipeWithAPIRecipe:(APIRecipe *)APIRecipe {
    Recipe *recipe = [[Recipe alloc] init];
    
    recipe.identifier = @(APIRecipe.recipeId).stringValue;
    recipe.title = APIRecipe.title;
    recipe.category = APIRecipe.category;
    recipe.subcategory = APIRecipe.subcategory;
    recipe.imageURL = APIRecipe.imageURL;
    
    NSMutableArray *ingredients = [NSMutableArray array];
    for (APIIngredient *ingredient in APIRecipe.ingredients) {
        [ingredients addObject:[self ingredientWithAPIIngredient:ingredient]];
    }
    recipe.ingredients = [NSArray arrayWithArray:ingredients];
    recipe.instructions = APIRecipe.instructions;
    
    return recipe;
}

+ (Recipe *)recipeWithAPIRecipeBrief:(APIRecipeBrief *)APIRecipeBrief {
    Recipe *recipe = [[Recipe alloc] init];
    
    recipe.identifier = @(APIRecipeBrief.recipeId).stringValue;
    recipe.title = APIRecipeBrief.title;
    recipe.category = APIRecipeBrief.category;
    recipe.subcategory = APIRecipeBrief.subcategory;
    recipe.imageURL = APIRecipeBrief.imageURL;
    
    return recipe;
}

+ (Ingredient *)ingredientWithAPIIngredient:(APIIngredient *)APIIngredient {
    Ingredient *ingredient = [[Ingredient alloc] init];
    
    ingredient.name = APIIngredient.information.name;
    ingredient.department = APIIngredient.information.department;
    ingredient.quantity = [[NSString stringWithFormat:@"%.2f", APIIngredient.metricQuantity] doubleValue];
    ingredient.quantityUnit = APIIngredient.metricUnit;
    
    return ingredient;
}

@end
