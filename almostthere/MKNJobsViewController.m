//
//  MKNJobsViewController.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNJobsViewController.h"

#import "UIScrollView+EmptyDataSet.h"

#import "MKNFavouritesCollectionViewController.h"

@interface MKNJobsViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong) NSMutableArray *jobs;

@property (strong) CLLocationManager *locationManager;
@property (strong) CLRegion *testRegion;

@property (strong) MKNGeoFenceManager *manager;

@property (strong) MKNFavouritesCollectionViewController *favsViewController;
@property (strong) UICollectionView *favsView;

@end

@implementation MKNJobsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jobs = [NSMutableArray array];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addJob:)];
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

#pragma mark - DZNEmptyDataSetSource Methods


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    NSString *viewControllerId = @"MKNFavouritesCollectionViewController";
    self.favsViewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    
    UIView *favsView = self.favsViewController.collectionView;
    favsView.autoresizingMask = UIViewAutoresizingNone;
    favsView.translatesAutoresizingMaskIntoConstraints = NO;
    
    return favsView;
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
