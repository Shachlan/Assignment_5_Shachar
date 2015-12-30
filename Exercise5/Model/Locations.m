// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "Locations.h"

NS_ASSUME_NONNULL_BEGIN

/// Mapping from country name to an array of location info.
typedef NSDictionary<NSString *, NSArray<LocationInfo *> *> LocationInfoByCountryNames;

/// Mutable mapping from country name to an array of location info.
typedef NSMutableDictionary<NSString *,NSArray<LocationInfo *> *> MutableLocationInfoByCountryNames;

/// Mutable mapping from country name to an array of location info.
typedef NSMutableDictionary<NSString *, NSMutableArray<LocationInfo *> *>
MutableLocationArraysInMutableMap;

@interface Locations()

/// Mapping of country name to locations in the country.
@property (strong, nonatomic) LocationInfoByCountryNames *locationsInfoByCountryName;

/// Names of keys in \c locationsInfoByCountryName, sorted alphabetically.
@property (strong, nonatomic) NSArray<NSString *> *sortedCountryNames;

@end

@implementation Locations

#pragma mark -
#pragma mark - Initialization
#pragma mark -

- (instancetype)initWithLocations:(NSArray<LocationInfo *> *)locations{
  if(self = [super init]) {
    LocationInfoByCountryNames *locationsInfoByCountry = [self mappingForLocationInfo:locations];
    self.locationsInfoByCountryName =
        [self mappingWithAlphabeticallySortedLocations:locationsInfoByCountry];
    self.sortedCountryNames =
        [[self.locationsInfoByCountryName allKeys]
        sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  }
  
  return self;
}

#pragma mark -
#pragma mark - Public Methods
#pragma mark -

- (NSString *)nameOfLocationWithIndex:(NSUInteger)locationIndex
                         countryIndex:(NSUInteger)countryIndex{
  return [self locationAtIndex:locationIndex inCountry:countryIndex].locationName;
}

- (NSString *)nameOfRegionWithIndex:(NSUInteger)locationIndex
                       countryIndex:(NSUInteger)countryIndex {
  return [self locationAtIndex:locationIndex inCountry:countryIndex].regionName;
}

- (NSString *)nameOfCountryWithIndex:(NSUInteger)countryIndex {
  return self.sortedCountryNames[countryIndex];
}

- (NSInteger)numberOfLocationsInCountry:(NSUInteger)countryIndex {
  NSString *key = [self nameOfCountryWithIndex:countryIndex];
  NSArray *locationsForKey = self.locationsInfoByCountryName[key];
  return locationsForKey.count;
}

#pragma mark -
#pragma mark - Auxiliary Methods
#pragma mark -

- (LocationInfo *)locationAtIndex:(NSInteger)locationIndex inCountry:(NSInteger)countryIndex {
  NSString *key = [self nameOfCountryWithIndex:countryIndex];
  return self.locationsInfoByCountryName[key][locationIndex];
}

- (LocationInfoByCountryNames *)mappingForLocationInfo:(NSArray<LocationInfo *> *)locations {
  MutableLocationArraysInMutableMap *mutableMapping = [[NSMutableDictionary alloc] init];
  
  for(LocationInfo *locationInfo in locations) {
    NSMutableArray *mutableLocations = mutableMapping[locationInfo.countryName];
    
    if(!mutableLocations) {
      mutableLocations = [[NSMutableArray alloc] init];
      [mutableMapping setObject:mutableLocations forKey:locationInfo.countryName];
    }
    
    [mutableLocations addObject:locationInfo];
  }
  
  return [mutableMapping copy];
}

- (LocationInfoByCountryNames *)mappingWithAlphabeticallySortedLocations:
    (LocationInfoByCountryNames *)locationsInfoByCountry {
  MutableLocationInfoByCountryNames *mutableMapping = [[NSMutableDictionary alloc] init];
  
  NSComparator comparator = [self locationInfoComparer];
  
  for(NSString *countryName in [locationsInfoByCountry allKeys]) {
    NSArray *locationsInfo = locationsInfoByCountry[countryName];
    mutableMapping[countryName] = [locationsInfo sortedArrayUsingComparator: comparator];
  }
  
  return [mutableMapping copy];
}

- (NSComparisonResult (^)(LocationInfo *first, LocationInfo *second))locationInfoComparer {
  return ^NSComparisonResult(LocationInfo *first, LocationInfo *second) {
    NSComparisonResult regionComparison =
        [first.regionName localizedCaseInsensitiveCompare:second.regionName];
    
    if(regionComparison != NSOrderedSame) {
      return regionComparison;
    }
    
    return [first.locationName localizedCaseInsensitiveCompare:second.locationName];
  };
}

#pragma mark -
#pragma mark - Properties
#pragma mark -

- (NSUInteger)numberOfCountries {
  return self.sortedCountryNames.count;
}

@end

NS_ASSUME_NONNULL_END
