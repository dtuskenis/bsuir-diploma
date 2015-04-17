//
//  RecipesManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "RecipesManager.h"

#import "SearchRequest.h"
#import "ServiceManager.h"
#import "QMKWeakSet.h"

static NSString* const kRecipesCacheKey = @"recipes";

@interface RecipesManager ()

@property (nonatomic, strong) QMKWeakSet *observers;

@property (nonatomic, strong) ServiceManager *serviceManager;

@property (nonatomic, strong) NSMutableArray *favoriteRecipes;
@property (nonatomic, strong) NSMutableArray *recentRecipes;

@end

@implementation RecipesManager

- (instancetype)initWithServiceManager:(ServiceManager *)serviceManager {
    self = [super init];
    if (self) {
        self.serviceManager = serviceManager;
        self.observers = [[QMKWeakSet alloc] init];
        self.maximumNumberOfRecentlyViewedRecipes = 10;
        [self initRecipes];
    }
    return self;
}

- (NSArray *)favorites {
    return [NSArray arrayWithArray:self.favoriteRecipes];
}

- (NSArray *)recent {
    return [NSArray arrayWithArray:self.recentRecipes];
}

- (void)getRecipeWithIdentifier:(NSString *)identifier
                   successBlock:(void (^)(Recipe *recipe))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock {
    [self.serviceManager getRecipeWithIdentifier:identifier successBlock:successBlock failureBlock:failureBlock];
}

- (void)addRecipeToFavorites:(Recipe *)recipe {
    if ([self.favoriteRecipes containsObject:recipe] == NO) {
        [self.favoriteRecipes addObject:recipe];
        [self cacheRecipes];
        [self notifyObserversDidUpdateHistory];
    }
}

- (void)removeRecipeFromFavorites:(Recipe *)recipe {
    [self.favoriteRecipes removeObject:recipe];
    [self cacheRecipes];
    [self notifyObserversDidUpdateHistory];
}

- (BOOL)isFavoriteRecipe:(Recipe *)recipe {
    return [self.favoriteRecipes containsObject:recipe];
}

- (void)setRecipeRecentlyViewed:(Recipe *)recipe {
    if ([self.recentRecipes containsObject:recipe]) {
        [self.recentRecipes removeObject:recipe];
    } else {
        (self.recentRecipes.count == self.maximumNumberOfRecentlyViewedRecipes) ? [self.recentRecipes removeLastObject] : 0;
    }
    [self.recentRecipes insertObject:recipe atIndex:0];
    [self cacheRecipes];
    [self notifyObserversDidUpdateHistory];
}

#pragma mark -
#pragma mark Private

- (void)cacheRecipes {
    NSDictionary *recipes = @{ NSStringFromSelector(@selector(favorites)) : self.favoriteRecipes,
                               NSStringFromSelector(@selector(recent)) : self.recentRecipes };
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:recipes] forKey:kRecipesCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)initRecipes {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kRecipesCacheKey];
    NSDictionary *recipes = data ? [NSKeyedUnarchiver unarchiveObjectWithData:data] : @{};
    self.favoriteRecipes = [NSMutableArray arrayWithArray:recipes[NSStringFromSelector(@selector(favorites))]];
    self.recentRecipes = [NSMutableArray arrayWithArray:recipes[NSStringFromSelector(@selector(recent))]];
}

#pragma mark -
#pragma mark Observeable

- (void)addObserver:(id<RecipesManagerObserver>)observer {
    [self.observers addObject:observer];
}

- (void)removeObserver:(id<RecipesManagerObserver>)observer {
    [self.observers removeObject:observer];
}

- (void)notifyObserversDidUpdateHistory {
    for (id<RecipesManagerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(recipesManagerDidUpdateHistory:)]) {
            [observer recipesManagerDidUpdateHistory:self];
        }
    }
}

@end
