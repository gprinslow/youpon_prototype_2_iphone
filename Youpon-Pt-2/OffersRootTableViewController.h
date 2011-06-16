//
//  OffersRootTableViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/5/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffersEditTableViewController.h"

@interface OffersRootTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate> {
    
    @private
    NSFetchedResultsController *__fetchedResultsController;
    OffersEditTableViewController *editTableViewController;
}
@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet OffersEditTableViewController *editTableViewController;

- (IBAction)toggleEdit;

@end
