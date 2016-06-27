//
//  MKNSelectMessageTypeTableViewController.m
//  almostthere
//
//  Created by Marcel Koch on 08.08.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNSelectMessageTypeTableViewController.h"

@interface MKNSelectMessageTypeTableViewController () {
    NSDictionary *messageTypes;
    NSArray *sectionTitles;
}
@end

@implementation MKNSelectMessageTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    messageTypes = @{@"Mail" : @[@"johanna@bodmaenner.de", @"j.bodmann@gmx.de"],
                @"SMS" : @[@"01735363456"]};
    
    sectionTitles = [[messageTypes allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSArray *sectionMessageTypes = [messageTypes objectForKey:sectionTitle];
    return [sectionMessageTypes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionMessageType = [messageTypes objectForKey:sectionTitle];
    NSString *messageType = [sectionMessageType objectAtIndex:indexPath.row];
    cell.textLabel.text = messageType;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionMessageType = [messageTypes objectForKey:sectionTitle];
    NSString *address = [sectionMessageType objectAtIndex:indexPath.row];
    
    NSLog(@"Message Type %@", sectionTitle);
    
    MKNAlmostThereMessageType messageType;
    
    if ([sectionTitle isEqualToString:@"Mail"]) {
        messageType = MKNAlmostThereMessageTypeMail;
    } else {
        messageType = MKNAlmostThereMessageTypeSms;
    }
    
    [self.delegate addItemViewController:self didSelectMessageType:messageType AndAdress:address];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
