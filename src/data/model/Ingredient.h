//
//  Ingredient.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "Model.h"

typedef NS_ENUM(NSUInteger, IngredientQuantityUnit) {
    kIngredientQuantityUnitUnknown = 0,
};

@interface Ingredient : Model

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, assign) CGFloat quantity;
@property (nonatomic, assign) NSString *quantityUnit;

@end
