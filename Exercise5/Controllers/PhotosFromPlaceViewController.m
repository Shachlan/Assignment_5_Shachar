// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PhotosFromPlaceViewController.h"

#import "EXTScope.h"

#import "FlickrFetcher.h"
#import "FlickrPhotoInfoParser.h"
#import "ImageViewController.h"
#import "PhotoInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosFromPlaceViewController()

/// Photos displayed in table.
@property (strong, nonatomic) NSArray *photos;

@end

@implementation PhotosFromPlaceViewController

// Maximum number of photos we'll query from the location.
static const int kMaxPhotosPerLocation = 50;

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
  [self fetchPhotosFromPlace];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  NSIndexPath *index = [self.tableView indexPathForCell:sender];
  if (!index || ![segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
    return;
  }
  
  ImageViewController *destination = segue.destinationViewController;
  PhotoInfo *photo = [self.photos objectAtIndex:index.item];
  destination.photoInfo = photo;
  destination.title = photo.photoTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView
                           dequeueReusableCellWithIdentifier:@"Picture at location cell"
                           forIndexPath:indexPath];
  PhotoInfo *photo = [self.photos objectAtIndex:indexPath.item];
  cell.textLabel.text = photo.photoTitle;
  cell.detailTextLabel.text = photo.photoDescription;
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.photos.count;
}

#pragma mark -
#pragma mark Internal functions
#pragma mark -

- (void)updatePhotos:(NSArray<NSDictionary *> *)photos {
  id<PhotoInfoParser> parser = [[FlickrPhotoInfoParser alloc] init];
  NSMutableArray *photoArray = [[NSMutableArray alloc] init];
  for (NSDictionary *photoAsDictionary in photos) {
    PhotoInfo *photoInfo = [parser photoInfoFromDictionary:photoAsDictionary];
    if (photoInfo) {
      [photoArray addObject:photoInfo];
    }
  }
  self.photos = [photoArray copy];
  [self.tableView reloadData];
}

- (void)fetchPhotosFromPlace {
  [self.refreshControl beginRefreshing];
  @weakify(self);
  [FlickrFetcher downloadPhotosFromPlace:self.placeId maxResults:kMaxPhotosPerLocation
                          withCompletion:^(NSArray *photos) {
                             @strongify(self);
    [self updatePhotos:photos];
    [self.refreshControl endRefreshing];
  }
                                andError:^(NSError *error) {
    NSLog(@"%@", error);
    [self.refreshControl endRefreshing];
  }];
}

@end

NS_ASSUME_NONNULL_END
