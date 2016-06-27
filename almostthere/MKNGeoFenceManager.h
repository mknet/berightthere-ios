//
//  MKNGeoFenceManager.h
//  almostthere
//
//  Created by Marcel Koch on 12.06.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface MKNGeoFenceManager : NSObject <CLLocationManagerDelegate>

- (id)initWithLocationManager:(CLLocationManager *)manager;
- (id)initWithRegion:(CLRegion *)region;
- (void)stopWatching;
- (void)startWatching:(CLRegion *)region;
- (void)onInsideRegion:(CLRegion *)region;

//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region;
@end
