// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "LocationInfo.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationInfo()

/// Name of location.
@property (strong, readwrite, nonatomic) NSString *locationName;

/// Name of the region the location is in.
@property (strong, readwrite, nonatomic) NSString *regionName;

/// Name of the country the location is in.
@property (strong, readwrite, nonatomic) NSString *countryName;

@end

@implementation LocationInfo

- (instancetype)initWithLocationName:(NSString *)locationName
                          regionName:(NSString *)regionName
                      andCountryName:(NSString *)countryName {
  if(self = [super init]) {
    self.locationName = locationName;
    self.regionName = regionName;
    self.countryName = countryName;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
