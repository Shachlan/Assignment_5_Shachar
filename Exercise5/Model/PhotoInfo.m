// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PhotoInfo.h"

#import "FlickrInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoInfo()

/// Title of photo.
@property (strong, readwrite, nonatomic) NSString *photoTitle;

/// Description of photo.
@property (strong, readwrite, nonatomic) NSString *photoDescription;

/// URL for photo download.
@property (strong, readwrite, nonatomic) NSURL *url;

@end

@implementation PhotoInfo

- (instancetype)initWithPhotoTitle:(NSString *)photoTitle
                  photoDescription:(NSString *)photoDescription
                            url:(NSURL *)url {
  if (self = [super init]) {
    self.url = url;
    self.photoTitle = photoTitle;
    self.photoDescription = photoDescription;
  }
  return self;
}
@end

NS_ASSUME_NONNULL_END
