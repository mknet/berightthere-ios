//
//  MKNFavouritesCollectionViewController.m
//  almostthere
//
//  Created by Marcel Koch on 11.07.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNFavouritesCollectionViewController.h"
#import "MKNContactsManager.h"
#import "MKNAppDelegate.h"
#import "RHPerson.h"

@implementation MKNFavouritesCollectionViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    MKNAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MKNContactsManager *contactsManager = appDelegate.contactsManager;
    
    self.favs = contactsManager.favourites;

}

#pragma mark CollectionView methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.favs count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    RHPerson *person = [self.favs objectAtIndex:indexPath.row];
    
    UIButton *button = (UIButton *)[cell viewWithTag:100];
    UIImage *image = person.originalImage;
    [button setImage:image forState:UIControlStateNormal];
    
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.layer setCornerRadius:25.0f];
    
    return cell;
}

- (IBAction)favTapped:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        RHPerson *person = [self.favs objectAtIndex:indexPath.row];
        NSLog(@"Der Wert lautet %@", person);
    }

}

@end
