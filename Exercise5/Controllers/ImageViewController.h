//
//  ImageViewController.h
//  Imaginarium
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoInfo;

/// Controller for the Image view. Downloads and displays an image from a given URL.
@interface ImageViewController : UIViewController

/// Info about the image that this view will display.
@property (nonatomic, strong) PhotoInfo *photoInfo;

@end
