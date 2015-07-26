//
//  MKNFavouritesCollectionViewController.m
//  almostthere
//
//  Created by Marcel Koch on 11.07.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNFavouritesCollectionViewController.h"

@implementation MKNFavouritesCollectionViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.favs = [[NSMutableArray alloc] init];
    
    [self.favs addObject:@"Eins"];
    [self.favs addObject:@"Zwo"];
    [self.favs addObject:@"Drei"];
    [self.favs addObject:@"Vier"];
    [self.favs addObject:@"Fünf"];
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
    
    UIButton *button = (UIButton *)[cell viewWithTag:100];
    [button setTitle:[self.favs objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.layer setCornerRadius:10.0f];
    
    return cell;
}

- (IBAction)buttonTouched:(id)sender {    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        NSLog(@"Der Wert lautet %@", [self.favs objectAtIndex:indexPath.row]) ;
    }
}
@end
