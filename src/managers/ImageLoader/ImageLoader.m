//
//  ImageLoader.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "ImageLoader.h"

#import "Haneke.h"

@interface ImageLoader ()

@property (nonatomic, strong) NSMutableDictionary *imageViews;

@end

@implementation ImageLoader

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
            self.imageScale = [[UIScreen mainScreen] nativeScale];
        } else {
            self.imageScale = [[UIScreen mainScreen] scale];
        }
        self.imageViews = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getImageWithURL:(NSURL *)url
                   size:(CGSize)size
           successBlock:(void (^)(UIImage *image))successBlock
           failureBlock:(void (^)(NSError *error))failureBlock {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.imageViews setObject:imageView forKey:url];
    [imageView hnk_setImageFromURL:url placeholder:nil success:^(UIImage *image) {
        [self.imageViews removeObjectForKey:url];
        successBlock(image);
    } failure:^(NSError *error) {
        [self.imageViews removeObjectForKey:url];
        failureBlock(error);
    }];
}

- (void)terminateFetchingOfImageWithURL:(NSURL *)url {
    [(UIImageView *)self.imageViews[url] hnk_cancelSetImage];
    [self.imageViews removeObjectForKey:url];
}

@end
