//
//  MKNGeoFenceManagerTest.m
//  almostthere
//
//  Created by Marcel Koch on 14.06.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MKNGeoFenceManager.h"

@interface MKNGeoFenceManagerTest : XCTestCase

@property (strong) MKNGeoFenceManager *manager;

@end

@implementation MKNGeoFenceManagerTest

id mockManager;
CLCircularRegion *region;


- (void)setUp
{
    [super setUp];
    
    mockManager = OCMClassMock([CLLocationManager class]);
    self.manager = [[MKNGeoFenceManager alloc] initWithLocationManager:mockManager];
    
    CLLocationCoordinate2D coords;
    coords.longitude=8.783666797422859;
    coords.latitude=50.0488850458406;
    
    CLLocationDistance radius = 500.0;
    
    region = [[CLCircularRegion alloc] initWithCenter:coords radius:radius
                                           identifier:@"XCTRegion"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)instantiation
{
    
    
    
}

- (void)testStartWatching
{
    [self.manager startWatching:region];
    
    OCMVerify([mockManager startMonitoringForRegion:region]);
    OCMVerify([mockManager setDesiredAccuracy:kCLLocationAccuracyBest]);
}

- (void)testOnInsideRegion
{
    [self.manager locationManager:mockManager didEnterRegion:region];
    OCMVerify([self.manager onInsideRegion:region]);
}

@end
