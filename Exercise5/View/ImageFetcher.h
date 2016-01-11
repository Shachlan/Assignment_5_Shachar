// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Immutable object performing asynchronous loading of images.
@interface ImageFetcher : NSObject

/// Asynchronously downloads an image from the given \c url. Upon successful completion, the given
/// \c completion block is executed. In case of an error, the given \c error block is executed.
+ (void)downloadImageFromUrl:(NSURL *)url
              withCompletion:(void (^)(UIImage *))completion
                    error:(void (^)(NSError *))error;

@end

NS_ASSUME_NONNULL_END
