// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Controller for the photos from specific place view. Retrieves photos from the Flickr API
/// that were taken in a place defined by the \c placeId property. The property should be set
/// before the VC appears.
@interface PhotosFromPlaceViewController : UITableViewController

/// Flickr Id of a location. The VC will display photos from this location.
@property (strong, nonatomic) NSString *placeId;

@end

NS_ASSUME_NONNULL_END
