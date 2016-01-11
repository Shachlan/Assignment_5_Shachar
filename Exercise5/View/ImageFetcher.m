// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "ImageFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ImageFetcher

+ (void)downloadImageFromUrl:(NSURL *)url
              withCompletion:(void (^)(UIImage *))completion
                    error:(void (^)(NSError *))error {
  dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
  dispatch_async(fetchQ, ^{
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
      dispatch_async(dispatch_get_main_queue(), ^{
        error([NSError errorWithDomain:NSPOSIXErrorDomain code:EIO userInfo:nil]);
      });
      return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(image);
    });
  });
}

@end

NS_ASSUME_NONNULL_END
