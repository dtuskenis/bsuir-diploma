//
//  ImageLoader.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SharedInstance.h"

@interface ImageLoader : SharedInstance

@property (nonatomic, assign) CGFloat imageScale;

- (void)getImageWithURL:(NSURL *)url
                   size:(CGSize)size
           successBlock:(void (^)(UIImage *image))successBlock
           failureBlock:(void (^)(NSError *error))failureBlock;

- (void)terminateFetchingOfImageWithURL:(NSURL *)url;

@end
