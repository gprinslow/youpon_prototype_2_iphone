//
//  RedeemServiceRequest.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/17/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceRequest.h"

@interface RedeemServiceRequest : ServiceRequest {
    NSManagedObject *offer;
}

@property (nonatomic, retain) NSManagedObject *offer;

@end
