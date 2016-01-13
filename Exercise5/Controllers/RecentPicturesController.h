// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Controller for the Recent Pictures view. This controller fetches a list of most recent photos
/// that were viewed and when any of them is chosen, segues to the ImageViewController to display
/// it.
@interface RecentPicturesController : UITableViewController
@end

NS_ASSUME_NONNULL_END
