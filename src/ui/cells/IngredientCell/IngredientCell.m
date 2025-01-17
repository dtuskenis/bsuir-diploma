//
//  IngredientCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/5/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "IngredientCell.h"

#import "Ingredient.h"

@interface IngredientCell ()

@property (nonatomic, weak) IBOutlet UILabel *leftLabel;
@property (nonatomic, weak) IBOutlet UILabel *rightLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightLabelWidth;

@end

@implementation IngredientCell

@synthesize item = _item;

- (void)setItem:(Ingredient *)item {
    _item = item;
    [self fillWithItem:item];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.rightLabelWidth.constant = 0;
}

- (void)fillWithItem:(Ingredient *)item {
    
    self.leftLabel.text = item.name;
    
    self.rightLabel.text = [NSString stringWithFormat:@"%@ %@", @(item.quantity).stringValue, item.quantityUnit];
    [self.rightLabel sizeToFit];
    self.rightLabelWidth.constant = self.rightLabel.frame.size.width;
}

@end
