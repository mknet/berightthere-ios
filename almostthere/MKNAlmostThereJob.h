//
//  MKNMessage.h
//  almostthere
//
//  Created by Marcel Koch on 31.07.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

typedef NS_ENUM(NSInteger, MKNAlmostThereMessageType) {
    MKNAlmostThereMessageTypeMail,
    MKNAlmostThereMessageTypeSms
};

@interface MKNAlmostThereJob : NSObject

@property NSString *recipient;
@property NSString *address;

@property CLLocationCoordinate2D coordinate;

@property NSString *messageText;

@property MKNAlmostThereMessageType messageType;

@property NSString *recipientMailAddress;

@end
