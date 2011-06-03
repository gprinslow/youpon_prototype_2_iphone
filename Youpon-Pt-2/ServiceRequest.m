//
//  ServiceRequest.m
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "ServiceRequest.h"


@implementation ServiceRequest

@synthesize requestTime;
@synthesize requestType;
@synthesize requestorUsername;
@synthesize requestorPassword;



- (void)dealloc
{
    [requestTime release];
    [requestType release];
    [requestorUsername release];
    [requestorPassword release];
    [super dealloc];
}

@end
