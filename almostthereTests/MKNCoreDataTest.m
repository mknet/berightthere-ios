//
//  MKNCoreDataTest.m
//  almostthere
//
//  Created by Marcel Koch on 30.08.15.
//  Copyright (c) 2015 Marcel Koch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>

#import "MKNAlmostThereJob.h"

@interface MKNCoreDataTest : XCTestCase

@property NSManagedObjectContext *moc;

@end

@implementation MKNCoreDataTest

- (void)setUp {
    [super setUp];
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    NSError *error;
    
    if(![psc addPersistentStoreWithType:NSInMemoryStoreType
                                                configuration:nil
                                                          URL:nil
                                                      options:nil
                                                        error:&error]) {
         XCTFail(@"Could not create store coordinator: %@", [error localizedDescription]);
    }

    self.moc = [[NSManagedObjectContext alloc] init];
    self.moc.persistentStoreCoordinator = psc;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSManagedObjectContext *context = [self moc];
    MKNAlmostThereJob *job = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"Job"
                                      inManagedObjectContext:context];
    job.address = @"Heusenstamm";
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Job"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (MKNAlmostThereJob *job in fetchedObjects) {
        NSLog(@"Address: %@", job.address);
    }
}

@end
