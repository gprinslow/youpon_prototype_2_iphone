//
//  RedeemServiceStub.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/17/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "RedeemServiceStub.h"

@implementation RedeemServiceStub

-(RedeemServiceResponse *)callRedeemServiceStub:(RedeemServiceRequest *)redeemRequest {
    RedeemServiceResponse *redeemResponse = [[RedeemServiceResponse alloc] init];
    [redeemResponse setRequest:redeemRequest];
    [redeemResponse setResponseType:[redeemRequest requestType]];
    
    if (redeemRequest != nil) {
        if ([redeemRequest requestType] != nil) {
            if ([[redeemRequest requestType] isEqualToString:@"REDEEM"]) {
                
                if ([redeemRequest.offer valueForKey:@"startDate"] >= [NSDate date]) {
                    if ([redeemRequest.offer valueForKey:@"expirationDate"] < [NSDate date]) {
                        [redeemResponse setResponseTime:[NSDate date]];
                        [redeemResponse setResponseCode:@"SUCCESS"];
                        [redeemResponse setResponseDetail:@"Valid redemption request"];
                    }
                    else {
                        [redeemResponse setResponseTime:[NSDate date]];
                        [redeemResponse setResponseCode:@"FAILURE"];
                        [redeemResponse setResponseDetail:@"Offer has expired"];
                    }
                }
                else {
                    [redeemResponse setResponseTime:[NSDate date]];
                    [redeemResponse setResponseCode:@"FAILURE"];
                    [redeemResponse setResponseDetail:@"Offer has not started yet"];
                }
            }
        }
    }
    
    
    return redeemResponse;
}


@end
