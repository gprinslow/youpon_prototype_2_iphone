//
//  RedeemServiceStub.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/17/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedeemServiceRequest.h"
#import "RedeemServiceResponse.h"

@interface RedeemServiceStub : NSObject {
    
}

-(RedeemServiceResponse *)callRedeemServiceStub:(RedeemServiceRequest *)redeemRequest;

@end
