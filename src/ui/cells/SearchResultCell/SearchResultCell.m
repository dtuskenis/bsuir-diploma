//
//  SearchResultCell.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchResultCell.h"

#import "Haneke.h"
#import "Recipe.h"
#import "UIColor+Custom.h"

@interface SearchResultCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor applicationBackgroundColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [[UIColor applicationDefaultColor] colorWithAlphaComponent:0.1];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.thumbnailImageView hnk_cancelSetImage];
    self.thumbnailImageView.image = nil;
}

- (void)setItem:(Recipe *)item {
    [super setItem:item];
    [self fillWithItem:item];
}

- (void)fillWithItem:(Recipe *)item {
    self.titleLabel.text = (item.title ? item.title : @"");
    self.infoLabel.text = [NSString stringWithFormat:@"%@ / %@", item.category, item.subcategory];
    
    [self.thumbnailImageView hnk_setImageFromURL:[NSURL URLWithString:item.imageURL] placeholder:nil success:^(UIImage *image) {
        self.thumbnailImageView.image = image;
    } failure:^(NSError *error) {}];
}

@end
