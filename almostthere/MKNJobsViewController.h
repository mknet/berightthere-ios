//
//  MKNJobsViewController.h
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

#import "MKNGeoFenceManager.h"
#import "MKNAppDelegate.h"

@interface MKNJobsViewController : UITableViewController <CLLocationManagerDelegate>

@property MKNAppDelegate *app;

@end
