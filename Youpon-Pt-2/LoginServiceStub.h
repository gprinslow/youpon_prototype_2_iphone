//
//  LoginServiceStub.h
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceRequest.h"
#import "ServiceResponse.h"

@interface LoginServiceStub : NSObject {
    
}

-(ServiceResponse *)callLoginServiceStub:(ServiceRequest *)loginRequest;

@end
