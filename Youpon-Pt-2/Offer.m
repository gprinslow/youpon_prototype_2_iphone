//
//  Offer.m
//  Youpon-Pt-2
//
//  Created by Garrison on 7/1/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "Offer.h"


@implementation Offer

@synthesize type;
@synthesize title;
@synthesize byline;
@synthesize category;
@synthesize detailedDescription;
@synthesize termsConditions;
@synthesize retailPrice;
@synthesize discountPrice;
@synthesize percentOff;
@synthesize dollarValue;
@synthesize validationRequired;
@synthesize numberOffered;
@synthesize startDate;
@synthesize expirationDate;
@synthesize numberStampsRequired;
@synthesize offerId;

- (void)dealloc
{
    [type release];
    [title release];
    [byline release];
    [category release];
    [detailedDescription release];
    [termsConditions release];
    [retailPrice release];
    [discountPrice release];
    [percentOff release];
    [dollarValue release];
    [validationRequired release];
    [numberOffered release];
    [startDate release];
    [expirationDate release];
    [numberStampsRequired release];
    [offerId release];
    [super dealloc];
}


@end
