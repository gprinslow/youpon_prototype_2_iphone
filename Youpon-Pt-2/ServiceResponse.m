//
//  ServiceResponse.m
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "ServiceResponse.h"


@implementation ServiceResponse

@synthesize responseTime;
@synthesize responseType;
@synthesize responseCode;
@synthesize responseDetail;
@synthesize request;


- (void)dealloc
{
    [responseTime release];
    [responseType release];
    [responseCode release];
    [responseDetail release];
    [request release];
    [super dealloc];
}

@end
