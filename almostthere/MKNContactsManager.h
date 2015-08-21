//
//  MKNContactsManager.h
//  almostthere
//
//  Created by Marcel Koch on 18.09.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//
//  Takes care of loading the people from the adressbook

#import <RHAddressBook/AddressBook.h>

@interface MKNContactsManager : NSObject

- (id)initWithRHAddressBook:(RHAddressBook *)ab;
- (NSArray*)peopleWithAtLeastOneAdress;
- (NSArray*)favourites;

@end
