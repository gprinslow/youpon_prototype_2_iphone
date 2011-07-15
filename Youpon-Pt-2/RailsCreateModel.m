//
//  RailsCreateModel.m
//  Youpon-Pt-2
//
//  Created by Garrison on 7/11/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "RailsCreateModel.h"


@implementation RailsCreateModel

@synthesize item;
@synthesize data;
@synthesize itemCreatedNotificationName;

- (id)init {
    self = [super init];
    if (self) {
        //Class specific initialization
        if (!item) {
            self.item = [[NSDictionary alloc] init];
        }
    }
    return self;
}

- (void)dealloc {
    [item release];
    [data release];
    [super dealloc];
}

#pragma mark - Custom methods - Send Request

- (BOOL)sendCreateRequest:(NSString *)model requestURL:(NSString *)requestURL requestHTTPMethod:(NSString *)requestHTTPMethod {
    
    NSString *theURLString = [NSString stringWithFormat:@"%@%@", requestURL, model];
    
    NSMutableURLRequest *theURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:theURLString]];
    
    [theURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theURLRequest setHTTPMethod:requestHTTPMethod];
    
    NSString *theHTTPRequestParameters = [self.item JSONRepresentation];
    
    NSData *jsonDataRequest = [theHTTPRequestParameters dataUsingEncoding:NSUTF8StringEncoding];
    [theURLRequest setValue:[[NSNumber numberWithInt:[jsonDataRequest length]] stringValue] forHTTPHeaderField:@"Content-Length"];
    [theURLRequest setHTTPBody:jsonDataRequest];
    
    NSURLConnection *theURLConnection = [NSURLConnection connectionWithRequest:theURLRequest delegate:self];
    
    if (theURLConnection != nil) {
        self.data = [[NSMutableData alloc] init];
        return true;
    }
    return false;
}

- (BOOL)sendCreateRequest:(NSString *)model requestURL:(NSString *)requestURL requestHTTPMethod:(NSString *)requestHTTPMethod requestHTTPParameters:(NSString *)requestHTTPParameters {
    
    NSString *theURLString = [NSString stringWithFormat:@"%@%@", requestURL, model];
    
    NSMutableURLRequest *theURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:theURLString]];
    
    [theURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theURLRequest setHTTPMethod:requestHTTPMethod];
    
    NSData *jsonDataRequest = [requestHTTPParameters dataUsingEncoding:NSUTF8StringEncoding];
    [theURLRequest setValue:[[NSNumber numberWithInt:[jsonDataRequest length]] stringValue] forHTTPHeaderField:@"Content-Length"];
    [theURLRequest setHTTPBody:jsonDataRequest];
    
    NSURLConnection *theURLConnection = [NSURLConnection connectionWithRequest:theURLRequest delegate:self];
    
    if (theURLConnection != nil) {
        self.data = [[NSMutableData alloc] init];
        return true;
    }
    return false;
}
            

#pragma mark - NSURLConnection Delegate methods
#pragma mark - NSURLConnection Delegate methods - REQUIRED Delegate Methods

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData {
    [self.data appendData:newData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error on URL Connection: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString = [[NSString alloc] initWithData:[self data] encoding:NSUTF8StringEncoding];
    
    NSLog(@"CreateRequestResponse: %@", responseString);    
        
    //Post notification that items were updated
    [[NSNotificationCenter defaultCenter] postNotificationName:[self itemCreatedNotificationName] object:self];

    //Memory management
    [responseString release];
}

@end
