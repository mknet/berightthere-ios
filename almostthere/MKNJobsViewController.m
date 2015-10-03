//
//  MKNJobsViewController.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "UIScrollView+EmptyDataSet.h"

#import "MKNJobsViewController.h"
#import "MKNFavouritesCollectionViewController.h"
#import "MKNAlmostThereJob.h"

@interface MKNJobsViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong) NSArray *jobs;

@property (strong) CLLocationManager *locationManager;
@property (strong) CLRegion *testRegion;

@property (strong) MKNGeoFenceManager *manager;

@property (strong) MKNFavouritesCollectionViewController *favsViewController;
@property (strong) UICollectionView *favsView;

@property (strong) UIView *viewBla;

@end

@implementation MKNJobsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.app = [[UIApplication sharedApplication] delegate];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addJob:)];
    
    [self.app.geofenceManager startWatching];
    
    [self updateJobList];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateJobList];
}

- (void)viewDidAppear {
    [self updateJobList];
}

- (void)updateJobList {
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Job"
                                              inManagedObjectContext:self.app.managedObjectContext];
    [fetchRequest setEntity:entity];
    self.jobs = [self.app.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addJob:(id)sender
{
    [self performSegueWithIdentifier:@"addJob" sender:sender];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jobs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    MKNAlmostThereJob *job = [self.jobs objectAtIndex:indexPath.row];
    cell.textLabel.text = job.recipient;
    
    return cell;
}

#pragma mark - DZNEmptyDataSetSource Methods


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    NSString *viewControllerId = @"MKNFavouritesCollectionViewController";
    self.favsViewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    
    self.favsView = self.favsViewController.collectionView;
    self.favsView.autoresizingMask = UIViewAutoresizingNone;
    self.favsView.translatesAutoresizingMaskIntoConstraints = NO;
    
    return self.favsView;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return CGPointMake(0, 45);
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

@end
