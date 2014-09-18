//
//  MKNContactsManager.m
//  almostthere
//
//  Created by Marcel Koch on 18.09.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNContactsManager.h"

@interface MKNContactsManager ()

@property (strong) RHAddressBook *addressBook;

@end

@implementation MKNContactsManager

- (id)initWithRHAddressBook:(RHAddressBook *)ab
{
    self.addressBook = ab;
    
    return self;
}

- (NSArray*)peopleWithAtLeastOneAdress
{
    NSArray *people = [self.addressBook peopleOrderedByFirstName];
    NSMutableArray *result = [NSMutableArray array];
    
    for(RHPerson *person in people) {
        if ([[person.addresses values] count] > 0){
            [result addObject:person];
        }
    }
    return result;
}

@end
