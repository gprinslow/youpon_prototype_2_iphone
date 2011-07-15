//
//  RailsCreateModel.h
//  Youpon-Pt-2
//
//  Created by Garrison on 7/11/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface RailsCreateModel : NSObject {
    NSDictionary *item;
    NSMutableData *data;
    NSString *itemCreatedNotificationName;
}

@property (nonatomic, retain) NSDictionary *item;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *itemCreatedNotificationName;


- (BOOL)sendCreateRequest:(NSString *)model requestURL:(NSString *)requestURL requestHTTPMethod:(NSString *)requestHTTPMethod;
- (BOOL)sendCreateRequest:(NSString *)model requestURL:(NSString *)requestURL requestHTTPMethod:(NSString *)requestHTTPMethod requestHTTPParameters:(NSString *)requestHTTPParameters;

@end
