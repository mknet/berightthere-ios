//
//  MKNWriteMessageViewController.m
//  almostthere
//
//  Created by Marcel Koch on 20.07.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNWriteMessageViewController.h"
#import "MKNAlmostThereJob.h"
#import "MKNSelectMessageTypeTableViewController.h"
#import "MKNAppDelegate.h"

@interface MKNWriteMessageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *messageText;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIPickerView *messageTypePicker;

- (IBAction)createJob:(id)sender;

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
    
    self.name.text = self.message.recipient;
    self.address.text = self.message.address;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Speichern" style: UIBarButtonItemStyleDone target:self action:@selector(saveJob:)];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [self.message addObserver:self forKeyPath:@"coordinate" options:0 context:NULL];
    
    NSString *buttonText;
    
    if (self.message.messageType == MKNAlmostThereMessageTypeMail) {
        buttonText = [NSString stringWithFormat:@"Mail - %@", self.message.recipientAddress];
    } else if (self.message.messageType == MKNAlmostThereMessageTypeSms) {
        buttonText = [NSString stringWithFormat:@"SMS - %@", self.message.recipientAddress];
    }
    
    [self.messageTypeButton setTitle:buttonText forState:UIControlStateNormal];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.message removeObserver:self forKeyPath:@"coordinate"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"coordinate"]) {
        //self.address.text = [NSString stringWithFormat:@"%f", self.message.coordinate.longitude];
    }
}

- (IBAction)createJob:(id)sender {
    //TODO Remove me?
}

- (void)saveJob:(id)sender
{
    MKNAppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSError *error;
    if (![app.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }


    [app.geofenceManager startWatching:[self.message createRegion]];
    
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectMessageType"]) {

        MKNSelectMessageTypeTableViewController *selectMessageTypeController = segue.destinationViewController;
        selectMessageTypeController.delegate = self;
    }
}

+ (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}

- (void) addItemViewController:(MKNSelectMessageTypeTableViewController *)controller didSelectMessageType:(MKNAlmostThereMessageType)messageType AndAdress:(NSString *)adress
{
    self.message.messageType = messageType;
    self.message.recipientAddress = adress;
}

- (void)gotGeolocation:(CLLocationCoordinate2D)location
{
    self.message.coordinate = location;
    
    self.geoLocationLabel.text = [NSString stringWithFormat:@"%f %f", location.longitude, location.latitude];
}


@end
