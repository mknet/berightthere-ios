//
//  MKNJobsManager.m
//  almostthere
//
//  Created by Marcel Koch on 31.10.14.
//  Copyright (c) 2014 Marcel Koch. All rights reserved.
//

#import "MKNJobsManager.h"
#import "Parse/Parse.h"

@implementation MKNJobsManager

-(void) saveJob
{
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

-(void) printJobs
{
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    
    NSArray *objects = [query findObjects];
    
    // The find succeeded.
    NSLog(@"Successfully retrieved %d scores.", objects.count);
    // Do something with the found objects
    for (PFObject *object in objects) {
        NSLog(@"%@", object.objectId);
    }
}

@end
