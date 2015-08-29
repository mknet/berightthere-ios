//
//  MKNAlmostThereJob.h
//  almostthere
//
//  Created by Marcel Koch on 29.08.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CLLocation.h>

typedef NS_ENUM(NSInteger, MKNAlmostThereMessageType) {
    MKNAlmostThereMessageTypeMail,
    MKNAlmostThereMessageTypeSms
};

@interface MKNAlmostThereJob : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * messageText;
@property (nonatomic, retain) NSNumber * messageTypeValue;
@property (nonatomic, retain) NSString * recipientAddress;
@property (nonatomic, retain) NSString * senderName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * recipient;

-(MKNAlmostThereMessageType)messageType;
-(void)setMessageType:(MKNAlmostThereMessageType)type;

-(CLLocationCoordinate2D)coordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)coordinate;

@end
