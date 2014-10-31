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

@end
