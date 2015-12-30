// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Controller for the Top Places view. This controller fetches a list of top places from Flickr,
/// displays them sorted by country and region, and clicking on each location will lead to
/// a view displaying photos from that location. 
@interface TopPlacesViewController : UITableViewController
@end

NS_ASSUME_NONNULL_END
