//
//  CollectionViewCell.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/17/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id item;

+ (NSString *)cellIdentifier;
+ (UINib *)cellNib;

@end
