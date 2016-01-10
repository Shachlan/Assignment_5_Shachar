// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Immutable value object containing all basic information regarding a given location.
@interface LocationInfo : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c locationName, \c regionName, \c countryName and \c placeId.
- (instancetype)initWithLocationName:(NSString *)locationName regionName:(NSString *)regionName
                         countryName:(NSString *)countryName
                          placeId:(NSString *)placeId NS_DESIGNATED_INITIALIZER;

/// Name of location.
@property (readonly, nonatomic) NSString *locationName;

/// Name of the region the location is in.
@property (readonly, nonatomic) NSString *regionName;

/// Name of the country the location is in.
@property (readonly, nonatomic) NSString *countryName;

/// Id identifying the photo in the relevant web API.
@property (readonly, nonatomic) NSString *placeId;

@end

NS_ASSUME_NONNULL_END
