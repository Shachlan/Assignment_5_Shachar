// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "FlickrPhotoInfoParser.h"

#import "FlickrInformation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrPhotoInfoParser

// Default title for photos with an unknown title.
static NSString * const kUnknownPhotoTitle = @"Unknown";

- (PhotoInfo *)photoInfoFromDictionary:(NSDictionary *)unparsedPhotoInfo {
  NSURL *url = [FlickrInformation URLforPhoto:unparsedPhotoInfo format:FlickrPhotoFormatOriginal];
  if (!url) {
    return nil;
  }
  
  NSString *photoTitle = [unparsedPhotoInfo valueForKeyPath:FLICKR_PHOTO_TITLE];
  NSString *photoDescription = [unparsedPhotoInfo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
  
  if (!photoTitle || !photoTitle.length) {
    if (photoDescription && photoDescription.length) {
      photoTitle = photoDescription;
      photoDescription = @"";
    } else {
      photoTitle = kUnknownPhotoTitle;
      photoDescription = @"";
    }
  }
  return [[PhotoInfo alloc] initWithPhotoTitle:photoTitle photoDescription:photoDescription
                                           url:url];
}

@end

NS_ASSUME_NONNULL_END
