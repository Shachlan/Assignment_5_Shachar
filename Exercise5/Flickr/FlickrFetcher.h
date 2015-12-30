// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Immutable object performing asynchronous loading of data from Flickr.
@interface FlickrFetcher : NSObject

/// Asynchronously downloads the Flickr information about top locations.
/// Upon completion, the given \c completion block is called with the downloaded data.
/// if there's an error in the download process, the given \c error block will be called with the
/// error.
+ (void)downloadTopPlaceInformationWithCompletion:(void (^)(NSArray *))completion
                                         andError:(void (^)(NSError *))error;

@end

NS_ASSUME_NONNULL_END
