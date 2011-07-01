//
//  Offer.h
//  Youpon-Pt-2
//
//  Created by Garrison on 7/1/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Offer : NSObject {
    NSString *type;
    NSString *title;
    NSString *byline;
    NSString *category;
    NSString *detailedDescription;
    NSString *termsConditions;
    NSString *retailPrice;
    NSString *discountPrice;
    NSString *percentOff;
    NSString *dollarValue;
    NSNumber *validationRequired;
    NSNumber *numberOffered;
    NSDate *startDate;
    NSDate *expirationDate;
    NSNumber *numberStampsRequired;
    NSString *offerId;
}

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *byline;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *detailedDescription;
@property (nonatomic, retain) NSString *termsConditions;
@property (nonatomic, retain) NSString *retailPrice;
@property (nonatomic, retain) NSString *discountPrice;
@property (nonatomic, retain) NSString *percentOff;
@property (nonatomic, retain) NSString *dollarValue;
@property (nonatomic, retain) NSNumber *validationRequired;
@property (nonatomic, retain) NSNumber *numberOffered;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *expirationDate;
@property (nonatomic, retain) NSNumber *numberStampsRequired;
@property (nonatomic, retain) NSString *offerId;


@end
