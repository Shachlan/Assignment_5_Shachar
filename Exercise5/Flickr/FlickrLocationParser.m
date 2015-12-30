// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "FlickrLocationParser.h"

#import "FlickrInformation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrLocationParser

- (LocationInfo *)locationInfoFromDictionary:(NSDictionary *)unParsedLocation {
  NSArray <NSString *> *parsedContent = [self parsedPlaceContentFromDictionary:unParsedLocation];
  NSString * locationName = [self locationNameFromParsedPlaceContent:parsedContent];
  NSString * regionName = [self regionNameFromParsedPlaceContent:parsedContent];
  NSString * countryName = [self countryNameFromParsedPlaceContent:parsedContent];
  
  if(![locationName length] || ![countryName length] || ![regionName length]) {
    return nil;
  }
  
  return [[LocationInfo alloc] initWithLocationName:locationName regionName:regionName
                                     andCountryName:countryName];
}

- (NSArray <NSString *> *)parsedPlaceContentFromDictionary:(NSDictionary *)placeInfo {
  return [placeInfo[FLICKR_PLACE_NAME] componentsSeparatedByString:@","];
}

- (NSString *)countryNameFromParsedPlaceContent:(NSArray <NSString *> *)placeContent {
  return [placeContent lastObject];
}

- (NSString *)locationNameFromParsedPlaceContent:(NSArray <NSString *> *)placeContent {
  return [placeContent firstObject];
}

- (NSString *)regionNameFromParsedPlaceContent:(NSArray <NSString *> *)placeContent {
  return placeContent.count > 2 ? placeContent[1] : @"";
}

@end

NS_ASSUME_NONNULL_END
