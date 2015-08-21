//
//  MKNSelectMessageTypeTableViewController.h
//  almostthere
//
//  Created by Marcel Koch on 08.08.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNAlmostThereJob.h"

@class MKNSelectMessageTypeTableViewController;

@protocol MKNSelectMessageTypeDelegate <NSObject>
- (void)addItemViewController:(MKNSelectMessageTypeTableViewController *)controller didSelectMessageType:(MKNAlmostThereMessageType)messageType AndAdress: (NSString *)adress;
@end

@interface MKNSelectMessageTypeTableViewController : UITableViewController

@property (nonatomic, strong) id <MKNSelectMessageTypeDelegate> delegate;

@end
