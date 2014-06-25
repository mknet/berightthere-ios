//
//  MKNGeoFenceManager.m
//  almostthere
//
//  Created by Marcel Koch on 12.06.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNGeoFenceManager.h"

@interface MKNGeoFenceManager ()

@property (strong) CLLocationManager *locationManager;
@property (strong) CLRegion *regionToWatch;

@end

@implementation MKNGeoFenceManager

- (id)initWithRegion:(CLRegion *)region
{
    self = [self init];
    self.regionToWatch = region;
    
    return self;
}

- (void)startWatching
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    //to get all results from the location manager
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    //be accurate as possible
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.locationManager startMonitoringForRegion:self.regionToWatch];
    
    NSLog(@"Monitored regions %@",self.locationManager.monitoredRegions);
}

- (void)stopWatching
{
    [self.locationManager stopMonitoringForRegion:self.regionToWatch];
    self.locationManager = nil;
    self.regionToWatch = nil;
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Du bist gleich da!");
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Ich gucke nach %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
     NSLog(@"Ich habe %f", region.center.latitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error : %@",error);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

@end

