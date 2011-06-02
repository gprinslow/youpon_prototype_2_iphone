//
//  ServiceRequest.h
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServiceRequest : NSObject {
    NSDate *requestTime;
    NSString *requestType;
    NSString *requestorUsername;
    NSString *requestorPassword;
}

@property (nonatomic, retain) NSDate *requestTime;
@property (nonatomic, retain) NSString *requestType;
@property (nonatomic, retain) NSString *requestorUsername;
@property (nonatomic, retain) NSString *requestorPassword;



@end
