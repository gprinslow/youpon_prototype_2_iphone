//
//  OffersRedeemViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/17/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersRedeemViewController : UIViewController {
    UIActivityIndicatorView *actValidatingActivityIndicator;    
    UILabel *lblValidatingStatusMessage;
    UILabel *lblSuccessMessage;
    UILabel *lblSuccessDetailMessage;
    UILabel *lblFailureMessage;
    UILabel *lblFailureDetailMessage;
    UILabel *lblBackMessage;
}

@property (nonatomic, retain) NSManagedObject *offer;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *actValidatingActivityIndicator;
@property (nonatomic, retain) IBOutlet UILabel *lblValidatingStatusMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblSuccessMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblSuccessDetailMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblFailureMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblFailureDetailMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblBackMessage;

//Action Methods
- doRedeemAction:(id)sender;


@end
