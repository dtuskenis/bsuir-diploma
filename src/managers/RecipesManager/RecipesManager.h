//
//  RecipesManager.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@class Recipe;
@class SearchRequest;
@class ServiceManager;

@protocol RecipesManagerObserver;

@interface RecipesManager : NSObject

@property (nonatomic, readonly) NSArray *favorites;
@property (nonatomic, readonly) NSArray *recent;

@property (nonatomic, assign) NSInteger maximumNumberOfRecentlyViewedRecipes;

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager;

- (void)searchRecipesWithRequest:(SearchRequest *)searchRequest
                    successBlock:(void (^)(NSArray *searchResults))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

- (void)getRecipeWithIdentifier:(NSString *)identifier
                   successBlock:(void (^)(Recipe *recipe))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

- (void)addRecipeToFavorites:(Recipe *)recipe;
- (void)removeRecipeFromFavorites:(Recipe *)recipe;
- (BOOL)isFavoriteRecipe:(Recipe *)recipe;

- (void)setRecipeRecentlyViewed:(Recipe *)recipe;

- (void)addObserver:(id<RecipesManagerObserver>)observer;
- (void)removeObserver:(id<RecipesManagerObserver>)observer;

@end

@protocol RecipesManagerObserver <NSObject>

@optional
- (void)recipesManagerDidUpdateHistory:(RecipesManager *)recipesManager;

@end
