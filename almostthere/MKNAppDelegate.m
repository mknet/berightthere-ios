//
//  MKNAppDelegate.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNAppDelegate.h"
#import "Parse/Parse.h"

@implementation MKNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self initContactsManager];
    [self initGeoFenceManager];
    
    [Parse setApplicationId:@"52MArBOtYcwF4cExRv145kx53C84Gieoy1E69d8f"
                  clientKey:@"yN48kT6rNWjvy5rx0QWSGikmlRV5CzhyofVyNY81"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - MK Geofence Manager

- (void) initGeoFenceManager
{
    CLLocationCoordinate2D coords;
    coords.longitude=-0.1015987;
    coords.latitude=51.5286416;
    
    CLLocationDistance radius = 5000.0;
    
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:coords
                                                                 radius:radius
                                                             identifier:@"geofence"];
    
    self.geofenceManager = [[MKNGeoFenceManager alloc] initWithRegion:region];
    [self.geofenceManager startWatching];
}

- (void) initContactsManager
{
    RHAddressBook *ab = [[RHAddressBook alloc] init];
    
    //query current status, pre iOS6 always returns Authorized
    if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined){
        
        //request authorization
        [ab requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
        }];
    }
    
    self.contactsManager = [[MKNContactsManager alloc] initWithRHAddressBook:ab];
}

@end
