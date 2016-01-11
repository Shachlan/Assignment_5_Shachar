// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PhotoInfo.h"

NS_ASSUME_NONNULL_BEGIN

// Protocol to be implemented by immutable objects creating \c PhotoInfo objects from given
/// dictionaries. The required structure of the given dictionaries depends on the implementation of
/// the object conforming to this protocol.
@protocol PhotoInfoParser <NSObject>

/// Returns the photo info represented by the given \c dictionary. In case that the given
/// \c dictionary does not have the required structure, \c nil will be returned.
- (PhotoInfo *)photoInfoFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
