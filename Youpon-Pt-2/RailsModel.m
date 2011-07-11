//
//  RailsModel.m
//  Youpon-Pt-2
//
//  Created by Garrison on 7/11/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "RailsModel.h"


@implementation RailsModel

@synthesize items;
@synthesize data;
@synthesize requestURL;
@synthesize requestHTTPHeaderField;
@synthesize requestHTTPHeaderFieldValue;
@synthesize requestHTTPMethod;
@synthesize itemsUpdatedNotificationName;


- (id)init {
    self = [super init];
    if (self) {
        //Class specific initialization
        if (!items) {
            self.items = [[NSArray alloc] init];
        }
        if (!data) {
            self.data = [[NSMutableData alloc] init];
        }
        
        [self refreshItems];
    }
    return self;
}

- (void)dealloc {
    [items release];
    [data release];
    [super dealloc];
}

- (NSInteger)count {
    return [items count];
}

- (NSDictionary *)item:(NSInteger)index {
    return [items objectAtIndex:index];
}

- (void)refreshItems {
    //Removed init check - now in self.init
    
    [self sendRequest];
}

- (BOOL)sendRequest {

    NSMutableURLRequest *theURLRequest = 
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self requestURL]]];
    
    [theURLRequest setValue:[self requestHTTPHeaderFieldValue] forHTTPHeaderField:[self requestHTTPHeaderField]];
    [theURLRequest setHTTPMethod:[self requestHTTPMethod]];
    
    NSURLConnection *theURLConnection = [NSURLConnection connectionWithRequest:theURLRequest delegate:self];
    
    if (theURLConnection != nil) {
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
    //Convert response from data into string (of JSON values)
    
    NSString *responseString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    
    NSDictionary *parsedJson = [jsonParser objectWithString:responseString];
    
    if (!parsedJson) {
        NSLog(@"-JSONValue failed.  Error is: %@", [[jsonParser error] description]);
    }
    else {
        //Store set of items retrieved
        self.items = [parsedJson objectForKey:@"items"];
        
        //Post notification that items were updated
        [[NSNotificationCenter defaultCenter] postNotificationName:self.itemsUpdatedNotificationName object:self];
    }
    
    //Memory management
    [responseString release];
    [jsonParser release];
}

@end
