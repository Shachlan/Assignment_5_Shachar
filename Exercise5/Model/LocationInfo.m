// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "LocationInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationInfo()

/// Name of location.
@property (readwrite, nonatomic) NSString *locationName;

/// Name of the region the location is in.
@property (readwrite, nonatomic) NSString *regionName;

/// Name of the country the location is in.
@property (readwrite, nonatomic) NSString *countryName;

/// Id identifying the photo in the relevant web API.
@property (readwrite, nonatomic) NSString *placeId;

@end

@implementation LocationInfo

- (instancetype)initWithLocationName:(NSString *)locationName regionName:(NSString *)regionName
                         countryName:(NSString *)countryName placeId:(NSString *)placeId {
  if (self = [super init]) {
    self.locationName = locationName;
    self.regionName = regionName;
    self.countryName = countryName;
    self.placeId = placeId;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
