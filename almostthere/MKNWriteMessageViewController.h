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

@interface MKNWriteMessageViewController : UIViewController <MKNSelectMessageTypeDelegate>

@property (strong) MKNAlmostThereJob *message;
@property (weak, nonatomic) IBOutlet UIButton *messageTypeButton;

@end
