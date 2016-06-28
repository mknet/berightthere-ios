//
//  MKNAlmostThereJob.m
//  almostthere
//
//  Created by Marcel Koch on 29.08.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNAlmostThereJob.h"


@implementation MKNAlmostThereJob

@dynamic id;
@dynamic latitude;
@dynamic longitude;
@dynamic messageText;
@dynamic messageTypeValue;
@dynamic recipientAddress;
@dynamic senderName;
@dynamic address;
@dynamic recipient;

-(MKNAlmostThereMessageType)messageType {
    return (MKNAlmostThereMessageType)[[self messageTypeValue] intValue];
}

-(void)setMessageType:(MKNAlmostThereMessageType)type {
    self.messageTypeValue = [NSNumber numberWithInt:type];
}

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

-(void)setCoordinate:(CLLocationCoordinate2D)coordinate {
    self.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:coordinate.longitude];
}

-(CLRegion *)createRegion
{
    CLLocationCoordinate2D coords;
    coords.longitude = [self.longitude doubleValue];
    coords.latitude = [self.latitude doubleValue];
    
    CLLocationDistance radius = 500.0;
    
    NSString *identifier = [self generateRegionHashIdentifier];
    
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:coords radius:radius
        identifier:identifier];
    
    return region;
}

-(NSString *)generateRegionHashIdentifier
{
    return [self.id stringValue];
}

@end
