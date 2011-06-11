//
//  OfferValueDisplay.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/10/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "OfferValueDisplay.h"


@implementation NSString (OfferValueDisplay)
- (NSString *)offerValueDisplay {
    return self;
}
@end

@implementation NSDate (OfferValueDisplay)
- (NSString *)offerValueDisplay {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *returnString = [formatter stringFromDate:self];
    [formatter release];
    return returnString;
}
@end

@implementation NSNumber (OfferValueDisplay)
- (NSString *)offerValueDisplay {
    return [self descriptionWithLocale:[NSLocale currentLocale]];
}
@end

@implementation NSDecimalNumber (OfferValueDisplay)
- (NSString *)offerValueDisplay {
    return [self descriptionWithLocale:[NSLocale currentLocale]];
}
@end

