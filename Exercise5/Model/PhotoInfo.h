// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Immutable value object containing all basic information regarding a given photo.
@interface PhotoInfo : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c photoTitle, \c photoDescription and \c url.
- (instancetype)initWithPhotoTitle:(NSString *)photoTitle
                  photoDescription:(NSString *)photoDescription
                               url:(NSURL *)url NS_DESIGNATED_INITIALIZER;

/// Title of photo.
@property (readonly, nonatomic) NSString *photoTitle;

/// Description of photo.
@property (readonly, nonatomic) NSString *photoDescription;

/// URL for photo download.
@property (readonly, nonatomic) NSURL *url;

@end

NS_ASSUME_NONNULL_END
