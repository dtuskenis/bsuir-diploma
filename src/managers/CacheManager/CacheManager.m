//
//  CacheManager.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/6/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CacheManager.h"

@interface CacheManager ()

@property (nonatomic, strong) NSURLCache *cache;
@property (nonatomic, strong) dispatch_queue_t performingQueue;
@property (nonatomic, strong) dispatch_queue_t callingQueue;

@end

@implementation CacheManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cache = [NSURLCache sharedURLCache];
        self.performingQueue = dispatch_queue_create([NSString stringWithFormat:@""].UTF8String, DISPATCH_QUEUE_SERIAL);
        self.callingQueue = dispatch_get_main_queue();
    }
    return self;
}

- (void)objectForKey:(NSString *)key recieveBlock:(void (^)(id object))recieveBlock {
    dispatch_async(self.performingQueue, ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:key]];
        NSCachedURLResponse *cachedResponse = [self.cache cachedResponseForRequest:request];
        id object = nil;
        if (cachedResponse) {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:cachedResponse.data];
        }
        dispatch_async(self.callingQueue, ^{
            recieveBlock(object);
        });
    });
}

- (void)cacheObject:(id<NSCoding>)object forKey:(NSString *)key completionBlock:(void (^)())completionBlock {
    dispatch_async(self.performingQueue, ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:key]];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[NSURL URLWithString:key] MIMEType:@"" expectedContentLength:0 textEncodingName:@""];
        NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:[NSKeyedArchiver archivedDataWithRootObject:object]];
        [self.cache  storeCachedResponse:cachedResponse forRequest:request];
        dispatch_async(self.callingQueue, ^{
            completionBlock();
        });
    });
}

@end
