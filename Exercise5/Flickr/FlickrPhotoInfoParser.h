// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PhotoInfoParser.h"

NS_ASSUME_NONNULL_BEGIN

/// Immutable object creating \c PhotoInfo objects from dictionaries in in the Flickr photo metadata
/// format.
@interface FlickrPhotoInfoParser : NSObject <PhotoInfoParser>
@end

NS_ASSUME_NONNULL_END
