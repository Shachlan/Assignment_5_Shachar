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

/// Asynchronously downloads the photo information for photos from given \c placeId (a string
/// uniquely identifying the place in Flickr) where number of photos is determined by \c maxResults.
/// Upon completion the given \c completion block is called with the photo data. Upon error, the
/// given \c error block is executed.
+ (void)downloadPhotosFromPlace:(NSString *)placeId
                     maxResults:(NSUInteger)maxResults
                 withCompletion:(void (^)(NSArray *))completion
                       andError:(void (^)(NSError *))error;

@end

NS_ASSUME_NONNULL_END
