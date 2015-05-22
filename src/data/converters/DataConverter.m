//
//  DataConverter.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "DataConverter.h"

#import "APIModel.h"
#import "Ingredient.h"
#import "Recipe.h"
#import "RecipesCategory.h"
#import "SearchRequest.h"

static NSString* const kImagePlaceholderURL = @"http://redirect.bigoven.com/pics/recipe-no-image.jpg";

@interface DataConverter ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation DataConverter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create([NSStringFromClass([self class]) stringByAppendingString:@"queue"].UTF8String, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (id)convertObjectWithObject:(id)object error:(NSError *__autoreleasing*)error {
    id result = nil;
    Class class = [object class];
    if (class == [APIRecipe class]) {
        result = [self convertRecipeWithRecipe:object];
    } else if (class == [APIRecipeBrief class]) {
        result = [self convertRecipeWithRecipeBrief:object];
    } else if (class == [SearchRequest class]) {
        result = [self convertSearchRequest:object];
    } else if (class == [APISearchResult class]) {
        result = [self convertSearchResults:object];
    } else {
        *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{ NSLocalizedDescriptionKey : @"Unsupported object class" }];
    }
    return result;
}

- (void)convertObjectWithObject:(id)object
                   successBlock:(void (^)(id object))successBlock
                   failureBlock:(void (^)(NSError *)) failureBlock {
    dispatch_async(self.queue, ^{
        NSError *error = nil;
        id result = [self convertObjectWithObject:object error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                successBlock(result);
            } else {
                failureBlock(error);
            }
        });
    });
}

- (APISearchRequest *)convertSearchRequest:(SearchRequest *)request {
    APISearchRequest *searchRequest = [[APISearchRequest alloc] init];
    if (request.keywords.count > 0) {
        searchRequest.title_kw = [request.keywords componentsJoinedByString:@" "];
    }
    if (request.categories.count > 0) {
        NSMutableArray *categories = [NSMutableArray array];
        for (RecipesCategory *category in request.categories) {
            [categories addObject:category.identifier];
        }
        searchRequest.include_primarycat = [categories componentsJoinedByString:@","];
    }
    searchRequest.pg = 1 + (int)((request.searchRange.location + request.searchRange.length) / 50);
    searchRequest.rpp = ((request.searchRange.location + request.searchRange.length) - (searchRequest.pg - 1) * 50);
    return searchRequest;
}

- (NSArray *)convertSearchResults:(APISearchResult *)searchResult {
    NSMutableArray *searchResults = [NSMutableArray array];
    
    for (APIRecipeBrief *recipeBrief in searchResult.results) {
        Recipe *recipe = [self convertRecipeWithRecipeBrief:recipeBrief];
        
        if (recipe) {
            [searchResults addObject:recipe];
        }
    }
    
    return [NSArray arrayWithArray:searchResults];
}

- (Recipe *)convertRecipeWithRecipe:(APIRecipe *)APIRecipe {
    
    // Validate
    if (APIRecipe.imageURL == nil || [APIRecipe.imageURL isEqualToString:kImagePlaceholderURL]) {
        return nil;
    }
    
    Recipe *recipe = [[Recipe alloc] init];
    
    recipe.identifier = @(APIRecipe.recipeId).stringValue;
    recipe.title = APIRecipe.title;
    recipe.category = APIRecipe.category;
    recipe.subcategory = APIRecipe.subcategory;
    recipe.imageURL = APIRecipe.imageURL;
    
    NSMutableArray *ingredients = [NSMutableArray array];
    for (APIIngredient *ingredient in APIRecipe.ingredients) {
        [ingredients addObject:[self convertIngredient:ingredient]];
    }
    recipe.ingredients = [NSArray arrayWithArray:ingredients];
    recipe.instructions = APIRecipe.instructions;
    
    return recipe;
}

- (Recipe *)convertRecipeWithRecipeBrief:(APIRecipeBrief *)APIRecipeBrief {
    
    // Validate
    if (APIRecipeBrief.imageURL == nil || [APIRecipeBrief.imageURL isEqualToString:kImagePlaceholderURL]) {
        return nil;
    }
    
    Recipe *recipe = [[Recipe alloc] init];
    
    recipe.identifier = @(APIRecipeBrief.recipeId).stringValue;
    recipe.title = APIRecipeBrief.title;
    recipe.category = APIRecipeBrief.category;
    recipe.subcategory = APIRecipeBrief.subcategory;
    recipe.imageURL = APIRecipeBrief.imageURL;
    
    return recipe;
}

- (Ingredient *)convertIngredient:(APIIngredient *)APIIngredient {
    Ingredient *ingredient = [[Ingredient alloc] init];
    
    ingredient.name = APIIngredient.information.name;
    ingredient.department = APIIngredient.information.department;
    ingredient.quantity = [[NSString stringWithFormat:@"%.2f", APIIngredient.metricQuantity] doubleValue];
    ingredient.quantityUnit = APIIngredient.metricUnit;
    
    return ingredient;
}

@end
