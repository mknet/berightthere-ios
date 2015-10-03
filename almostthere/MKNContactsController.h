//
//  MKNContactsController.h
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKNDeterminedGeolocationDelegate <NSObject>
- (void)gotGeolocation:(CLLocationCoordinate2D) location;
@end

@interface MKNContactsController : UITableViewController

@property (nonatomic, strong) id <MKNDeterminedGeolocationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
