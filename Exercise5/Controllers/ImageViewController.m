//
//  ImageViewController.m
//  Imaginarium
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "ImageViewController.h"

#import "ImageFetcher.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>

/// The image view.
@property (nonatomic, strong) UIImageView *imageView;

/// Displayed image.
@property (nonatomic, strong) UIImage *image;

/// The view that handles scrolling.
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/// Spinner that marks that an asynchronous operation is happening.
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

#pragma mark -
#pragma mark View Controller Lifecycle
#pragma mark -

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.scrollView addSubview:self.imageView];
  [self setupScrollView];
  [self startDownloadingImage];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

// lazy instantiation

- (UIImageView *)imageView
{
  if (!_imageView) _imageView = [[UIImageView alloc] init];
  return _imageView;
}

- (UIImage *)image
{
  return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
  self.imageView.image = image;
  self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  
  float widthAspet =  self.scrollView.bounds.size.width / image.size.width;
  float heightAspect = self.scrollView.bounds.size.height / image.size.height;
  self.scrollView.zoomScale = MAX(widthAspet, heightAspect);
  
  [self.spinner stopAnimating];
}

- (void)setupScrollView
{
  self.scrollView.minimumZoomScale = 0.01;
  self.scrollView.maximumZoomScale = 4.0;
  self.scrollView.delegate = self;
  self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
#pragma mark -

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

#pragma mark -
#pragma mark Setting the Image from the Image's URL
#pragma mark -

- (void)setImageURL:(NSURL *)imageURL
{
  _imageURL = imageURL;
}

- (void)startDownloadingImage
{
  if (self.imageURL)
  {
    [self.spinner startAnimating];
    [ImageFetcher downloadImageFromUrl:self.imageURL
                        withCompletion:^(UIImage *image) {
      self.image = image;
      [self.spinner stopAnimating];
    }
                              error:^(NSError *error) {
      NSLog(@"%@", [error description]);
      [self.spinner stopAnimating];
    }];
  }
}

@end
