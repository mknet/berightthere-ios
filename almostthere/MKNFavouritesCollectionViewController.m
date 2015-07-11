//
//  MKNFavouritesCollectionViewController.m
//  almostthere
//
//  Created by Marcel Koch on 11.07.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import "MKNFavouritesCollectionViewController.h"

@implementation MKNFavouritesCollectionViewController {
    
    NSMutableArray * array;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    array = [[NSMutableArray alloc] init];
    
    [array addObject:@"Hallo"];
    [array addObject:@"Welt"];
}

#pragma mark CollectionView methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [array count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = [array objectAtIndex:indexPath.row];
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.layer setCornerRadius:50.0f];
    
    return cell;
}

@end
