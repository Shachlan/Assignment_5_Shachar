// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "RecentPicturesController.h"

#import "ImageViewController.h"
#import "PhotoInfo.h"
#import "PhotoInfoStorage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecentPicturesController()

/// Array of photo info for the recently viewed photos.
@property (strong, nonatomic) NSArray<PhotoInfo *> *recentViewedPhotos;

@end

@implementation RecentPicturesController

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
  self.recentViewedPhotos = [PhotoInfoStorage storedPhotoInfo];
  [self.tableView reloadData];
  [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(_Nullable id)sender {
  NSIndexPath *index = [self.tableView indexPathForCell:sender];
  if (!index || ![segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
    return;
  }
  
  ImageViewController *destination = segue.destinationViewController;
  PhotoInfo *photo = [self.recentViewedPhotos objectAtIndex:index.item];
  destination.photoInfo = photo;
  destination.title = photo.photoTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView
                           dequeueReusableCellWithIdentifier:@"Recent viewed photo cell"
                           forIndexPath:indexPath];
  PhotoInfo *photo = [self.recentViewedPhotos objectAtIndex:indexPath.item];
  cell.textLabel.text = photo.photoTitle;
  cell.detailTextLabel.text = photo.photoDescription;
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.recentViewedPhotos.count;
}

@end

NS_ASSUME_NONNULL_END
