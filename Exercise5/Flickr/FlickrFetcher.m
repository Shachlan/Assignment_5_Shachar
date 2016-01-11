// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "FlickrFetcher.h"

#import "FlickrInformation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrFetcher

+ (void)downloadTopPlaceInformationWithCompletion:(void (^)(NSArray *))completion
                                         andError:(void (^)(NSError *))error {
  NSURL *url = [FlickrInformation URLforTopPlaces];
  [FlickrFetcher downloadItemsFromUrl:url withKey:FLICKR_RESULTS_PLACES
                       withCompletion:completion andError:error];
}

+ (void)downloadPhotosFromPlace:(NSString *)placeId maxResults:(NSUInteger)maxResults
                 withCompletion:(void (^)(NSArray *))completion
                       andError:(void (^)(NSError *))error {
  NSURL *url = [FlickrInformation URLforPhotosInPlace:placeId maxResults:maxResults];
  [FlickrFetcher downloadItemsFromUrl:url withKey:FLICKR_RESULTS_PHOTOS
                       withCompletion:completion andError:error];
}

+ (void)downloadItemsFromUrl:(NSURL *)url withKey:(NSString *)key
              withCompletion:(void (^)(NSArray *))completion andError:(void (^)(NSError *))error {
  dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
  dispatch_async(fetchQ, ^{
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    
    NSError *errorDescription = nil;
    NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0
                                                                          error:&errorDescription];
    if (!propertyListResults) {
      dispatch_async(dispatch_get_main_queue(), ^{
        error(errorDescription);
      });
      return;
    }
    
    NSArray *items = [propertyListResults valueForKeyPath:key];
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(items);
    });
  });
}

@end

NS_ASSUME_NONNULL_END
