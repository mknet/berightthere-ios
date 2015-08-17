//
//  MKNContactsController.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNAppDelegate.h"
#import "MKNAddressSelectionController.h"
#import "MKNContactsController.h"
#import "MKNAppDelegate.h"
#import "MKNWriteMessageViewController.h"
#import "MKNAlmostThereJob.h"

#import <RHAddressBook/AddressBook.h>

#import "UIScrollView+EmptyDataSet.h"

@interface MKNContactsController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong) MKNAppDelegate *app;
@property (strong) RHAddressBook *ab;
@property (strong) NSArray *contacts;

@end

@implementation MKNContactsController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.app = [[UIApplication sharedApplication] delegate];
    
    self.contacts = self.app.contactsManager.peopleWithAtLeastOneAdress;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Fertig" style: UIBarButtonItemStyleDone target:self action:@selector(closeView:)];

}

- (void)closeView:(id)sender
{
    [self dismissViewControllerAnimated:true completion:^{
        //
    }];
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
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
     
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
         
         MKNAlmostThereJob *message = [[MKNAlmostThereJob alloc] init];
         message.recipient = person.name;
         
         MKNWriteMessageViewController *writeMessageController = segue.destinationViewController;
         [writeMessageController setMessage:message];
         
         //TODO Extract address extraction code
         
         RHMultiValue *mv = [person addresses];
         
         if (mv.count > 1) {
             [self showAddressSelection:[mv values]];
         } else {
             
         
         NSDictionary *firstAddress = [mv valueAtIndex:0];
         
         NSString *addressString = [NSString stringWithFormat:@"%@ %@",
                                    [firstAddress objectForKey:@"Street"],
                                    [firstAddress objectForKey:@"City"],
                                    [firstAddress objectForKey:@"Country"]
                                    ];
             
         message.address = addressString;
         
         CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
         
         [geoCoder geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
             // There is no guarantee that the CLGeocodeCompletionHandler will be invoked on the main thread.
             // So we use a dispatch_async(dispatch_get_main_queue(),^{}) call to ensure that UI updates are always
             // performed from the main thread.
             //
             NSLog(@"Error %@", error);
             
             dispatch_async(dispatch_get_main_queue(),^ {
                 if (placemarks.count == 0)
                 {
                     // show an alert if no results were found
                     UIAlertView *alert = [[UIAlertView alloc] init];
                     alert.title = @"No places were found.";
                     [alert addButtonWithTitle:@"OK"];
                     [alert show];
                 } else {
                     CLPlacemark *placemark = placemarks[0]; // first placemark found
                     
                     message.coordinate = placemark.location.coordinate;
                 }
             });
         }];
         
         while (geoCoder.geocoding) {
             // we are waiting for world peace
         }
         }
     }
 }

- (void) showAddressSelection:(NSArray *)addresses {
    UIStoryboard *storyboard = self.storyboard;
    UINavigationController *addressController = [storyboard instantiateViewControllerWithIdentifier:@"AddressSelectionNav"];
    
    [self presentViewController:addressController animated:YES completion:nil];
}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No colors loaded";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"To show a list of random colors, tap on the refresh icon in the right top corner.\n\nTo clean the list, tap on the trash icon.";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    
}

@end
