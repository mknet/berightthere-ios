//
//  MKNJobManagerTest.m
//  almostthere
//
//  Created by Marcel Koch on 31.10.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MKNMessageManager.h"

@interface MKNMessageManagerTest : XCTestCase

@property (strong) MKNMessageManager *manager;

@end

@implementation MKNMessageManagerTest

- (void)setUp {
    [super setUp];
    self.manager = [[MKNMessageManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSendingMessage {
    [self.manager sendMessageByJobId:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
