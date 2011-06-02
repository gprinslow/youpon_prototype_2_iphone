//
//  LoginServiceStub.m
//  Youpon
//
//  Created by Garrison on 5/31/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "LoginServiceStub.h"


@implementation LoginServiceStub


/*
 *  Login Service Stub
 *  Fakes a couple usernames and passwords for initial prototype
 */
-(ServiceResponse *)callLoginServiceStub:(ServiceRequest *)loginRequest {
    ServiceResponse *loginResponse = [[ServiceResponse alloc] init];
    [loginResponse setRequest:loginRequest];
    [loginResponse setResponseType:[loginRequest requestType]];
    
    if (loginRequest != nil) {
        if ([loginRequest requestType] != nil) {
            if ([[loginRequest requestType] isEqualToString:@"LOGIN"]) {
                if ([loginRequest requestorUsername] && [loginRequest requestorPassword] != nil) {                    
                    if ([[loginRequest requestorUsername] isEqualToString:@"garrison"]) {
                        if ([[loginRequest requestorPassword] isEqualToString:@"asdf1"]) {
                            //Successful
                            
                            [loginResponse setResponseTime:[NSDate date]];
                            [loginResponse setResponseCode:@"SUCCESS"];
                            [loginResponse setResponseDetail:@"Valid username and password"];
                        }
                        else {
                            
                            [loginResponse setResponseTime:[NSDate date]];
                            [loginResponse setResponseCode:@"INVALID_PASSWORD"];
                            [loginResponse setResponseDetail:@"Invalid password for this username"];

                            NSLog(@"Login Service Stub - Invalid Request - Incorrect Password");
                        }
      
                    }
                    else if ([[loginRequest requestorUsername] isEqualToString:@"ron"]) {
                        if ([[loginRequest requestorPassword] isEqualToString:@"asdf2"]) {
                            //Successful
                            
                            [loginResponse setResponseTime:[NSDate date]];
                            [loginResponse setResponseCode:@"SUCCESS"];
                            [loginResponse setResponseDetail:@"Valid username and password"];
                            
                        }
                        else {
                            
                            [loginResponse setResponseTime:[NSDate date]];
                            [loginResponse setResponseCode:@"INVALID_PASSWORD"];
                            [loginResponse setResponseDetail:@"Invalid password for this username"];
                            
                            NSLog(@"Login Service Stub - Invalid Request - Incorrect Password");
                        }                        
                    }
                    else {
                        
                        [loginResponse setResponseTime:[NSDate date]];
                        [loginResponse setResponseCode:@"INVALID_USERNAME"];
                        [loginResponse setResponseDetail:@"Unrecognized username"];
                        
                        NSLog(@"Login Service Stub - Invalid Request - Unrecognized Username");
                    }
                }
                else {
                    NSLog(@"Login Service Stub - Invalid Request - Username and/or Password null");
                }
            }
            else {
                NSLog(@"Login Service Stub - Invalid Request - Request Type mismatch");
            }
        }
        else {
            NSLog(@"Login Service Stub - Invalid Request - Request Type null");
        }
    }
    else {
        NSLog(@"Login Service Stub - Invalid Request - LoginRequest null");
    }
    
    return loginResponse;
}

@end
