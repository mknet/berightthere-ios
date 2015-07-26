//
//  MKNFavouritesCollectionViewController.m
//  almostthere
//
//  Created by Marcel Koch on 11.07.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNFavouritesCollectionViewController.h"

@implementation MKNFavouritesCollectionViewController {
    
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.favs = [[NSMutableArray alloc] init];
    
    [self.favs addObject:@"Hallo"];
    [self.favs addObject:@"Welt"];
    [self.favs addObject:@"Hallo2"];
    [self.favs addObject:@"Welt2"];
    [self.favs addObject:@"Hallo3"];
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
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = [self.favs objectAtIndex:indexPath.row];
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.layer setCornerRadius:10.0f];
    
    return cell;
}

@end
