// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "TopPlacesViewController.h"

#import "FlickrFetcher.h"
#import "FlickrLocationParser.h"
#import "Locations.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopPlacesViewController()

// Locations displayed in the table.
@property (strong, nonatomic) Locations *locations;

@end

@implementation TopPlacesViewController

#pragma mark -
#pragma mark ViewController
#pragma mark -

- (void)viewDidLoad {
  [super viewDidLoad];
  [self fetchPlaces];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(_Nullable id)sender {
  // TODO:(shachar) implement next VC.
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Flickr photo cell"
                                                               forIndexPath:indexPath];
  cell.textLabel.text = [self.locations nameOfLocationWithIndex:indexPath.item
                                                   countryIndex:indexPath.section];
  cell.detailTextLabel.text = [self.locations nameOfRegionWithIndex:indexPath.item
                                                       countryIndex:indexPath.section];
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.locations.numberOfCountries;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.locations numberOfLocationsInCountry:section];
}

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section {
  return [self.locations nameOfCountryWithIndex:section];
}

#pragma mark -
#pragma mark Internal functions
#pragma mark -

- (void)fetchPlaces {
  [self.refreshControl beginRefreshing];
  [FlickrFetcher downloadTopPlaceInformationWithCompletion:^(NSArray * locations){
     [self updateLocations:locations];
     [self.refreshControl endRefreshing];
   }
     andError:^(NSError *error){
       NSLog(@"%@", error.description);
       [self.refreshControl endRefreshing];
   }];
}

- (void)updateLocations:(NSArray *)locations {
  id<LocationParser> parser = [[FlickrLocationParser alloc] init];
  self.locations = [[Locations alloc] initWithLocations:[self locationsFromDictionaries:locations
                                                                  parsedWithParser:parser]];
  [self.tableView reloadData];
}

- (NSArray<LocationInfo *> *)locationsFromDictionaries:(NSArray<NSDictionary *> *)unparsedLocations
                                 parsedWithParser:(id<LocationParser>)parser {
  NSMutableArray<LocationInfo *> *locations = [[NSMutableArray alloc] init];
  
  for(NSDictionary *unparsedLocation in unparsedLocations) {
    LocationInfo *location = [parser locationInfoFromDictionary:unparsedLocation];
    if(location) {
      [locations addObject:location];
    }
  }
  return locations;
}

@end

NS_ASSUME_NONNULL_END
