//
//  MKNGeoFenceManager.m
//  almostthere
//
//  Created by Marcel Koch on 12.06.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNGeoFenceManager.h"

@interface MKNGeoFenceManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong) CLRegion *regionToWatch;

@end

@implementation MKNGeoFenceManager

- (id)initWithLocationManager:(CLLocationManager *)manager
{
    self = [self init];
    self.locationManager = manager;
    return self;
}

- (id)initWithRegion:(CLRegion *)region
{
    self = [self init];
    self.regionToWatch = region;
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestAlwaysAuthorization];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Ich weiß gar nix");
    }
    
    self.locationManager.delegate = self;
    
    return self;
}

- (void)startWatching:(CLRegion *)region {
    
    //to get all results from the location manager
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    //be accurate as possible
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //[self.locationManager setPausesLocationUpdatesAutomatically:false];
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    
    [self.locationManager startMonitoringForRegion:self.regionToWatch];
    
    [self.locationManager performSelector:@selector(requestStateForRegion:) withObject:self.regionToWatch afterDelay:1];
    
    NSLog(@"Monitored regions %@",self.locationManager.monitoredRegions);
}

- (void)stopWatching
{
    [self.locationManager stopMonitoringForRegion:self.regionToWatch];
    self.locationManager = nil;
    self.regionToWatch = nil;
}

- (void)onInsideRegion:(CLRegion *)region
{
    NSLog(@"Du bist gleich in %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self onInsideRegion:region];
    return;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Ich gucke nach %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    if (state == CLRegionStateInside){
        [self onInsideRegion:region];
        return;
        
    } else if (state == CLRegionStateOutside){
        NSLog(@"Outside geofence: %@", region.identifier);
        return;
        
    } else if (state == CLRegionStateUnknown){
        NSLog(@"Unknown state for geofence: %@", region.identifier);
        return;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error : %@",error);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Failed Monitoring : %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Neue Locations");
    NSLog(@"%@",locations);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"%d",status);
}

@end

