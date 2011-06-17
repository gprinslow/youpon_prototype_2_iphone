//
//  OffersEditTableViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/10/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersEditTableViewController : UITableViewController {
    NSManagedObject *offer;
    
    @private
    NSArray *sectionNames;
    NSArray *rowLabels;
    NSArray *rowKeys;
    NSArray *rowControllers;
    NSArray *rowArguments;
}

@property (nonatomic, retain) NSManagedObject *offer;

-(IBAction)redeemOffer;

@end
