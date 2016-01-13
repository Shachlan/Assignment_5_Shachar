// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <Foundation/Foundation.h>

@class PhotoInfo;

NS_ASSUME_NONNULL_BEGIN

/// Immutable object for storing/retrieving photo info in/from persistent memory. The number of
/// storable photo infos is limited to 20.
@interface PhotoInfoStorage : NSObject

///  Persistently stores the given \c photoInfo as the most recently stored photo info. If already
/// \c photoInfo is stored, the old record will be deleted prior to storage. If already
/// \c kRecentPhotosLimit photo infos exist in storage, the least recently stored photo info is
/// removed before the given \c photoInfo is added.
+ (void)storePhotoInfo:(PhotoInfo *)photoInfo;

/// Returns the stored photo infos.
+ (NSArray<PhotoInfo *> *)storedPhotoInfo;

@end

NS_ASSUME_NONNULL_END
