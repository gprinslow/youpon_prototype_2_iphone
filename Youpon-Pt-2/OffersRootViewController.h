//
//  OffersRootViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/2/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffersRootTableViewController.h"

@interface OffersRootViewController : UIViewController {
    
    OffersRootTableViewController *offersRootTableViewController;
}

@property (nonatomic, retain) IBOutlet OffersRootTableViewController *offersRootTableViewController;

@end
