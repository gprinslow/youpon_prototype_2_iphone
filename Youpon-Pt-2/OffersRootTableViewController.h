//
//  OffersRootTableViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/5/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffersEditTableViewController.h"
#import "RailsModel.h"
#import "RailsCreateModel.h"

@interface OffersRootTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate> {
    
    RailsModel *offersRailsModel;
    RailsCreateModel *offersRailsCreateModel;
    
    @private
    NSFetchedResultsController *__fetchedResultsController;
    OffersEditTableViewController *editTableViewController;
}

@property (nonatomic, retain) RailsModel *offersRailsModel;
@property (nonatomic, retain) RailsCreateModel *offersRailsCreateModel;

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet OffersEditTableViewController *editTableViewController;


- (IBAction)toggleEdit;
- (void)reloadTableDataOnRemoteUpdate;



@end
