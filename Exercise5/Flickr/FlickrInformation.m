//
//  FlickrFetcher.m
//
//  Created for Stanford CS193p Fall 2013.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import "FlickrInformation.h"
#import "FlickrAPIKey.h"

@implementation FlickrInformation

+ (NSURL *)URLForQuery:(NSString *)query
{
  query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query, FlickrAPIKey];
  query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  return [NSURL URLWithString:query];
}

+ (NSURL *)URLforTopPlaces

{
  return [self URLForQuery:@"https://api.flickr.com/services/rest/?method=flickr.places.getTopPlacesList&place_type_id=7"];
}

+ (NSURL *)URLforPhotosInPlace:(id)flickrPlaceId maxResults:(NSUInteger)maxResults;
{
  return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&place_id=%@&per_page=%ld&extras=original_format,tags,description,geo,date_upload,owner_name,place_url", flickrPlaceId, maxResults]];
}

+ (NSURL *)URLforRecentGeoreferencedPhotos;
{
  return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&license=1,2,4,7&has_geo=1&extras=original_format,description,geo,date_upload,owner_name"]];
}

+ (NSString *)urlStringForPhoto:(NSDictionary *)photo format:(FlickrPhotoFormat)format
{
  id farm = [photo objectForKey:@"farm"];
  id server = [photo objectForKey:@"server"];
  id photo_id = [photo objectForKey:@"id"];
  id secret = [photo objectForKey:@"secret"];
  if (format == FlickrPhotoFormatOriginal) secret = [photo objectForKey:@"originalsecret"];
  
  NSString *fileType = @"jpg";
  if (format == FlickrPhotoFormatOriginal) fileType = [photo objectForKey:@"originalformat"];
  
  if (!farm || !server || !photo_id || !secret) return nil;
  
  NSString *formatString = @"s";
  switch (format) {
    case FlickrPhotoFormatSquare:    formatString = @"s"; break;
    case FlickrPhotoFormatLarge:     formatString = @"b"; break;
    case FlickrPhotoFormatOriginal:  formatString = @"o"; break;
  }
  
  return [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_%@.%@",
          farm, server, photo_id, secret, formatString, fileType];
}

+ (NSURL *)URLforPhoto:(NSDictionary *)photo format:(FlickrPhotoFormat)format;
{
  return [NSURL URLWithString:[self urlStringForPhoto:photo format:format]];
}

+ (NSURL *)URLforInformationAboutPlace:(id)flickrPlaceId
{
  return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.places.getInfo&place_id=%@", flickrPlaceId]];
}

#define FLICKR_PLACE_NEIGHBORHOOD_NAME @"neighbourhood._content"
#define FLICKR_PLACE_NEIGHBORHOOD_PLACE_ID @"neighbourhood.place_id"
#define FLICKR_PLACE_LOCALITY_NAME @"locality._content"
#define FLICKR_PLACE_LOCALITY_PLACE_ID @"locality.place_id"
#define FLICKR_PLACE_REGION_NAME @"region._content"
#define FLICKR_PLACE_REGION_PLACE_ID @"region.place_id"
#define FLICKR_PLACE_COUNTY_NAME @"county._content"
#define FLICKR_PLACE_COUNTY_PLACE_ID @"county.place_id"
#define FLICKR_PLACE_COUNTRY_NAME @"country._content"
#define FLICKR_PLACE_COUNTRY_PLACE_ID @"country.place_id"
#define FLICKR_PLACE_REGION @"region"

@end
