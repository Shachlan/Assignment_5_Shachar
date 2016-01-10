//
//  ImageViewController.h
//  Imaginarium
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Controller for the Image view. Downloads and displays an image from a given URL.
@interface ImageViewController : UIViewController

/// URL for the image that this view will display.
@property (nonatomic, strong) NSURL *imageURL;

@end
