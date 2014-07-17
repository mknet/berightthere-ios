//
//  MKNJobsViewController.m
//  almostthere
//
//  Created by Marcel Koch on 26.05.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNJobsViewController.h"

#import "UIScrollView+EmptyDataSet.h"

@interface MKNJobsViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation MKNJobsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
