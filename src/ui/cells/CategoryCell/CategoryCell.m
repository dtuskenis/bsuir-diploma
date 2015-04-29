//
//  CategoryCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/21/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CategoryCell.h"

#import "Haneke.h"
#import "RecipesCategory.h"
#import "UIColor+Custom.h"

@interface CategoryCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [[UIColor applicationDefaultColor] colorWithAlphaComponent:0.1];
}

- (void)setItem:(RecipesCategory *)item {
    [super setItem:item];
    [self fillWithItem:item];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.thumbnailImageView hnk_cancelSetImage];
    self.thumbnailImageView.image = nil;
}

- (void)fillWithItem:(RecipesCategory *)item {
    self.nameLabel.text = item.name;
    
    [self.thumbnailImageView hnk_setImageFromURL:[NSURL URLWithString:item.imageURL] placeholder:nil success:^(UIImage *image) {
        self.thumbnailImageView.image = image;
    } failure:^(NSError *error) {}];
}

@end
