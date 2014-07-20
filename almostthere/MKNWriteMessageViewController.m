//
//  MKNWriteMessageViewController.m
//  almostthere
//
//  Created by Marcel Koch on 20.07.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNWriteMessageViewController.h"

@interface MKNWriteMessageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *message;
@property (weak, nonatomic) IBOutlet UILabel *longitude;

@property (strong) NSString *contactName;

@end

@implementation MKNWriteMessageViewController

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
    
    self.name.text = self.contactName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)showLongitude:(double)longitude {
    self.longitude.text = [NSString stringWithFormat:@"%f", longitude];
}

@end
