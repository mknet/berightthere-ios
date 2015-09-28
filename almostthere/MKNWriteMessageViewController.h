//
//  MKNWriteMessageViewController.h
//  almostthere
//
//  Created by Marcel Koch on 20.07.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNAlmostThereJob.h"
#import "MKNSelectMessageTypeTableViewController.h"
#import "MKNContactsController.h"

@interface MKNWriteMessageViewController : UIViewController <MKNSelectMessageTypeDelegate, MKNDeterminedGeolocationDelegate>

@property (strong) MKNAlmostThereJob *message;
@property (weak, nonatomic) IBOutlet UIButton *messageTypeButton;
@property (weak, nonatomic) IBOutlet UILabel *geoLocationLabel;

@end
