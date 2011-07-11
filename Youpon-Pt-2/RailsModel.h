//
//  RailsModel.h
//  Youpon-Pt-2
//
//  Created by Garrison on 7/11/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface RailsModel : NSObject {
    NSArray *items;
    NSMutableData *data;
    NSString *requestURL;
    NSString *requestHTTPHeaderField;
    NSString *requestHTTPHeaderFieldValue;
    NSString *requestHTTPMethod;
    NSString *itemsUpdatedNotificationName;
}

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *requestURL;
@property (nonatomic, retain) NSString *requestHTTPHeaderField;
@property (nonatomic, retain) NSString *requestHTTPHeaderFieldValue;
@property (nonatomic, retain) NSString *requestHTTPMethod;
@property (nonatomic, retain) NSString *itemsUpdatedNotificationName;



- (NSInteger)count;
- (NSDictionary *)item:(NSInteger)index;
- (void)refreshItems;
- (BOOL)sendRequest;


@end
