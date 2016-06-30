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

typedef void (^insideRegionBlock)(NSString *jobId);

- (id)initWithLocationManager:(CLLocationManager *)manager AndInsideRegionBlock: (insideRegionBlock)callback;
- (void)stopWatching:(CLRegion *)region;
- (void)startWatching:(CLRegion *)region;
- (void)onInsideRegion:(CLRegion *)region;

@end
