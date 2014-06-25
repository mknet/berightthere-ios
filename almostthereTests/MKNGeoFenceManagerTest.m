//
//  MKNGeoFenceManagerTest.m
//  almostthere
//
//  Created by Marcel Koch on 14.06.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MKNGeoFenceManager.h"

@interface MKNGeoFenceManagerTest : XCTestCase

@end

@implementation MKNGeoFenceManagerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)instantiation
{
    
    
    
}


- (void)xxxtestExample
{
    NSLog(@"MK Test startet!");
    
    CLLocationCoordinate2D coords;
    coords.longitude=8.783666797422859;
    coords.latitude=50.0488850458406;
    
    CLLocationDistance radius = 500.0;
    
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:coords
                                                                 radius:radius
                                                             identifier:@"heusenstamm"];
    
    MKNGeoFenceManager *manager = [[MKNGeoFenceManager alloc] initWithRegion:region];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    
    [manager locationManager:locationManager didEnterRegion:region];
}

@end
