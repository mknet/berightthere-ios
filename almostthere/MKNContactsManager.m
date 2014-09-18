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
    NSArray *result = [self.addressBook people];
    
    return result;
}

@end
