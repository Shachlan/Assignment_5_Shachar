// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PhotoInfoStorage.h"

#import "PhotoInfo.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotoInfoStorage

// Serialized representation of PhotoInfo, using the keys in the consts below.
typedef NSDictionary<NSString *, NSString *> * SerializedPhotoInfo;

// Key for the url field of the photo info, when serialized to a dictionary.
static NSString * const kPhotoInfoUrl = @"url";

// Key for the title field of the photo info, when serialized to a dictionary.
static NSString * const kPhotoInfoTitle = @"title";

// Key for the description field of the photo info, when serialized to a dictionary.
static NSString * const kPhotoInfoDescription = @"description";

// Key for the list of recently viewed photos in the user defaults.
static NSString * const kRecentPhotosKey = @"RecentPhotos";

// Maximum number of photo infos to be saved in user defaults.
static const int kRecentPhotosLimit = 20;

+ (void)storePhotoInfo:(PhotoInfo *)photoInfo {
  NSMutableOrderedSet<SerializedPhotoInfo> *mutableRecentPhotos =
      [NSMutableOrderedSet orderedSetWithArray:[PhotoInfoStorage recentPhotosUnparsed]];
  SerializedPhotoInfo photoAsDictionary = [PhotoInfoStorage dictionaryFromPhotoInfo:photoInfo];
  if([mutableRecentPhotos containsObject:photoAsDictionary]) {
    [mutableRecentPhotos removeObject:photoAsDictionary];
  }
  [mutableRecentPhotos insertObject:photoAsDictionary atIndex:0];
  
  if(mutableRecentPhotos.count > kRecentPhotosLimit) {
    NSAssert(mutableRecentPhotos.count == kRecentPhotosLimit + 1,
             @"Recent photos info count: %ld", mutableRecentPhotos.count);
    [mutableRecentPhotos removeObjectAtIndex:kRecentPhotosLimit];
  }
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[mutableRecentPhotos array] forKey:kRecentPhotosKey];
  [defaults synchronize];
}

+ (NSArray<PhotoInfo *> *)storedPhotoInfo {
  NSArray<NSDictionary *> *recentPhotos = [PhotoInfoStorage recentPhotosUnparsed];
  
  NSMutableArray *parsedPhotos = [NSMutableArray arrayWithCapacity:recentPhotos.count];
  for(NSDictionary *dict in recentPhotos) {
    [parsedPhotos addObject:[PhotoInfoStorage photoInfoFromDictionary:dict]];
  }
  
  return [parsedPhotos copy];
}

+ (NSArray<SerializedPhotoInfo> *)recentPhotosUnparsed {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *recentPhotos = [defaults arrayForKey:kRecentPhotosKey];
  return recentPhotos ? [recentPhotos copy] : @[];
}

+ (SerializedPhotoInfo)dictionaryFromPhotoInfo:(PhotoInfo *)photoInfo {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  [dict setValue:[photoInfo.url absoluteString] forKey:kPhotoInfoUrl];
  [dict setValue:photoInfo.photoDescription forKey:kPhotoInfoDescription];
  [dict setValue:photoInfo.photoTitle forKey:kPhotoInfoTitle];
  return dict;
}

+ (PhotoInfo *)photoInfoFromDictionary:(SerializedPhotoInfo)dict{
  return [[PhotoInfo alloc] initWithPhotoTitle:dict[kPhotoInfoTitle]
                              photoDescription:dict[kPhotoInfoDescription]
                                           url:[NSURL URLWithString:dict[kPhotoInfoUrl]]];
}

@end

NS_ASSUME_NONNULL_END
