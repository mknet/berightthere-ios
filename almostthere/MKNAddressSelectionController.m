//
//  MKNAddressSelectionController.m
//  almostthere
//
//  Created by Marcel Koch on 18.09.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNAddressSelectionController.h"

@interface MKNAddressSelectionController ()

@end

@implementation MKNAddressSelectionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Feddich" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
