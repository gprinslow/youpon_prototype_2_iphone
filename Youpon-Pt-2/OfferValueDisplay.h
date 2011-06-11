//
//  OfferValueDisplay.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/10/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OfferValueDisplay
- (NSString *)offerValueDisplay;
@end

@interface NSString (OfferValueDisplay) <OfferValueDisplay>
- (NSString *)offerValueDisplay;
@end

@interface NSDate (OfferValueDisplay) <OfferValueDisplay>
- (NSString *)offerValueDisplay;
@end

@interface NSNumber (OfferValueDisplay) <OfferValueDisplay>
- (NSString *)offerValueDisplay;
@end

@interface NSDecimalNumber (OfferValueDisplay) <OfferValueDisplay>
- (NSString *)offerValueDisplay;
@end
