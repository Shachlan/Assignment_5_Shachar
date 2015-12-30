// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "LocationInfo.h"

NS_ASSUME_NONNULL_BEGIN

/// Protocol to be implemented by immutable objects creating \c LocationInfo objects from given
/// dictionaries. The required structure of the given dictionaries depends on the implementation of
/// the object conforming to this protocol.
@protocol LocationParser <NSObject>

/// Returns the location info represented by the given \c dictionary. In case that the dictionary
/// does not have the required structure, nil will be returned.
- (LocationInfo *)locationInfoFromDictionary:(NSDictionary *)unParsedLocation;

@end

NS_ASSUME_NONNULL_END
