//
//  ServiceResponse.h
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceRequest.h"

@interface ServiceResponse : NSObject {
    NSDate *responseTime;
    NSString *responseType;
    NSString *responseCode;
    NSString *responseDetail;
    ServiceRequest *request;
}

@property (nonatomic, retain) NSDate *responseTime;
@property (nonatomic, retain) NSString *responseType;
@property (nonatomic, retain) NSString *responseCode;
@property (nonatomic, retain) NSString *responseDetail;
@property (nonatomic, retain) ServiceRequest *request;


@end
