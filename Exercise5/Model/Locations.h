// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <Foundation/Foundation.h>

#import "LocationInfo.h"

NS_ASSUME_NONNULL_BEGIN

/// Immutable value object containing an ordered collection of locations,
/// sorted by country, region and location.
@interface Locations : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c locations.
- (instancetype)initWithLocations:(NSArray<LocationInfo *> *)locations NS_DESIGNATED_INITIALIZER;

/// Returns the number of locations in the country with the given \c index.
- (NSInteger)numberOfLocationsInCountry:(NSUInteger)countryIndex;

/// Returns the name of the country with the given \c index.
- (NSString *)nameOfCountryWithIndex:(NSUInteger)countryIndex;

/// Returns the name of location for the given country/location index.
- (NSString *)nameOfLocationWithIndex:(NSUInteger)locationIndex
                         countryIndex:(NSUInteger)countryIndex;

/// Returns the name of region for the given country/location index.
- (NSString *)nameOfRegionWithIndex:(NSUInteger)locationIndex
                       countryIndex:(NSUInteger)countryIndex;

/// Returns the Id of the photo for the given country/location index.
- (NSString *)placeIdWithIndex:(NSUInteger)locationIndex countryIndex:(NSUInteger)countryIndex;

/// Number of different countries of all locations represented by this object.
@property (readonly, nonatomic)NSUInteger numberOfCountries;

@end

NS_ASSUME_NONNULL_END
