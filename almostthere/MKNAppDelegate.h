//
//  MKNAppDelegate.h
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKNGeoFenceManager.h"

@interface MKNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong) MKNGeoFenceManager *geofenceManager;

@end
