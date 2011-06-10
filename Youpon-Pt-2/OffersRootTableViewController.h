//
//  OffersRootTableViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/5/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersRootTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
    UITableView *offersRootTableView;
    
    @private
    NSFetchedResultsController *__fetchedResultsController;
}
@property (nonatomic, retain) IBOutlet UITableView *offersRootTableView;
@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (IBAction)toggleEdit;

@end