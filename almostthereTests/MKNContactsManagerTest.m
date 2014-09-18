//
//  MKNContactsManagerTest.m
//  almostthere
//
//  Created by Marcel Koch on 18.09.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MKNContactsManager.h"


@interface MKNContactsManagerTest : XCTestCase

@property (strong) MKNContactsManager *manager;

@end

@implementation MKNContactsManagerTest

- (void)setUp
{
    [super setUp];
    RHAddressBook *ab = [[RHAddressBook alloc] init];
    self.manager = [[MKNContactsManager alloc] initWithRHAddressBook:ab];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPeopleWithAtLeastOneAddress
{
    NSArray *people = [self.manager peopleWithAtLeastOneAdress];
    
    XCTAssertTrue([people count] > 0, @"No people in the address book");
}

@end
