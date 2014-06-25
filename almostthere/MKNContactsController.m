//
//  MKNContactsController.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNContactsController.h"
#import "MKNAppDelegate.h"

#import <RHAddressBook/AddressBook.h>

@interface MKNContactsController ()

@property (strong) NSMutableArray *favourites;
@property (strong) RHAddressBook *ab;
@property (strong) NSArray *contacts;

@property (strong) CLLocationManager *locationManager;
@property (strong) CLRegion *testRegion;

@property (strong) MKNGeoFenceManager *manager;

@end

@implementation MKNContactsController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.favourites = [NSMutableArray array];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RHAddressBook *ab = [[RHAddressBook alloc] init];
	
    //query current status, pre iOS6 always returns Authorized
    if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined){
        
        //request authorization
        [ab requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
            self.ab = ab;
        }];
    }
    
    self.contacts = ab.people;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavouriteCell" forIndexPath:indexPath];
     
     RHPerson *person = self.contacts[indexPath.row];
     NSString *name = [person name];
     
     cell.textLabel.text = name;
     
     RHMultiValue *mv = [person addresses];
     NSDictionary *firstAddress = [mv valueAtIndex:0];
     
     cell.detailTextLabel.text = [firstAddress objectForKey:@"Street"];

     return cell;
 }

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([[segue identifier] isEqualToString:@"writeMessage"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         RHPerson *person = self.contacts[indexPath.row];
         
         //TODO Extract address extraction code
         
         RHMultiValue *mv = [person addresses];
         NSDictionary *firstAddress = [mv valueAtIndex:0];
         
         NSString *addressString = [NSString stringWithFormat:@"%@ %@",
                                    [firstAddress objectForKey:@"Street"],
                                    [firstAddress objectForKey:@"City"],
                                    [firstAddress objectForKey:@"Country"]
                                    ];
         
         CLGeocoder *geoCoder = [[CLGeocoder alloc] init];

         
         MKNAppDelegate *appDelegate = (MKNAppDelegate *)[[UIApplication sharedApplication] delegate];
         
         [geoCoder geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
             // There is no guarantee that the CLGeocodeCompletionHandler will be invoked on the main thread.
             // So we use a dispatch_async(dispatch_get_main_queue(),^{}) call to ensure that UI updates are always
             // performed from the main thread.
             //
             NSLog(@"Error %@", error);
             
             dispatch_async(dispatch_get_main_queue(),^ {
                 
                 CLPlacemark *placemark = placemarks[indexPath.row];
                 
                 CLLocationDegrees latitude = placemark.location.coordinate.latitude;
                 CLLocationDegrees longitude = placemark.location.coordinate.longitude;
                 
                 if (placemarks.count == 0)
                 {
                     // show an alert if no results were found
                     UIAlertView *alert = [[UIAlertView alloc] init];
                     alert.title = @"No places were found.";
                     [alert addButtonWithTitle:@"OK"];
                     [alert show];
                 }
             });
         }];
         
         while (geoCoder.geocoding) {
             // we are waiting for world peace
         }
         
         
         
     }
 }

@end
