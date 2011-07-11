//
//  OffersRootTableViewController.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/5/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

/*
 * REFACTOR: Ch.3 does not use tableViewController - so there is a cleaner way to implement add/edit than below
 *
 */


#import "OffersRootTableViewController.h"
#import "Youpon_Pt_2AppDelegate.h"
#import "Offer.h"


@implementation OffersRootTableViewController
@synthesize fetchedResultsController=__fetchedResultsController;
@synthesize editTableViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //editTableViewController = [[[OffersEditTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [__fetchedResultsController release];
    [editTableViewController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Ch.3 Edits
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Perform Fetch - Unresolved error %@, %@", error, [error userInfo]);
        NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if (detailedErrors != nil && [detailedErrors count] > 0) {
            for (NSError *detailedError in detailedErrors) {
                NSLog(@"--Detailed Error: %@", [detailedError userInfo]);
            }
        }
        else {
            NSLog(@"--%@", [error userInfo]);
        }
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:NSLocalizedString(@"Error loading data", @"Error loading data") 
                              message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.", @"Error was: %@, quitting."), [error localizedDescription]] 
                              delegate:self 
                              cancelButtonTitle:NSLocalizedString(@"OK, nevermind", @"OK, nevermind")
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Ch.3 Edits
    //REFACTOR: this would be unnecessary if used default TableViewController buttons...
    //Link edit button to toggleEdit
    UIBarButtonItem *editButton = self.editButtonItem;
    [editButton setTarget:self];
    [editButton setAction:@selector(toggleEdit)];
    self.navigationItem.leftBarButtonItem = editButton;
    
    //Add button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                  target:self 
                                  action:@selector(addOffer)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    //Added - to reload data
    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //Ch.3 edits
    NSUInteger count = [[self.fetchedResultsController sections] count];
    if (count == 0) {
        count = 1;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //Ch.3 edits
    NSArray *sections = [self.fetchedResultsController sections];
    NSUInteger count = 0;
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Ch.3 edits
    static NSString *OfferCellIdentifier = @"OfferCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OfferCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:OfferCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSManagedObject *oneOffer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [oneOffer valueForKey:@"title"];
    cell.detailTextLabel.text = [oneOffer valueForKey:@"byline"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Ch.3 Edits
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        
        if (![context save:&error]) {
            NSLog(@"Error saving deleted entity: %@", [error localizedDescription]);
            NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            if (detailedErrors != nil && [detailedErrors count] > 0) {
                for (NSError *detailedError in detailedErrors) {
                    NSLog(@"--Detailed Error: %@", [detailedError userInfo]);
                }
            }
            else {
                NSLog(@"--%@", [error userInfo]);
            }
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:NSLocalizedString(@"Error saving after delete", @"Error saving after delete") 
                                  message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.", @"Error was: %@, quitting."), [error localizedDescription]] 
                                  delegate:self 
                                  cancelButtonTitle:NSLocalizedString(@"OK, nevermind", @"OK, nevermind") 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }   
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    //Ch.3 edits
    //Instantiate detail editing controller and push onto stack
    editTableViewController.offer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:editTableViewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom methods added - Ch.3 - REFACTOR this b/c unnecessary with TableViewController

- (void)addOffer {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error saving entity: %@", [error localizedDescription]);
        NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if (detailedErrors != nil && [detailedErrors count] > 0) {
            for (NSError *detailedError in detailedErrors) {
                NSLog(@"--Detailed Error: %@", [detailedError userInfo]);
            }
        }
        else {
            NSLog(@"--%@", [error userInfo]);
        }
    }
    
    //Objective Resource - EXPERIMENTAL
    Offer *offer = [[[Offer alloc] init] autorelease];
    offer.type = [newManagedObject valueForKey:@"type"];
    offer.title = [newManagedObject valueForKey:@"title"];
    offer.byline = [newManagedObject valueForKey:@"byline"];
    offer.category = [newManagedObject valueForKey:@"category"];
    offer.detailedDescription = [newManagedObject valueForKey:@"detailedDescription"];
    offer.termsConditions = [newManagedObject valueForKey:@"termsConditions"];
    offer.retailPrice = [newManagedObject valueForKey:@"retailPrice"];
    offer.discountPrice = [newManagedObject valueForKey:@"discountPrice"];
    offer.percentOff = [newManagedObject valueForKey:@"percentOff"];
    offer.dollarValue = [newManagedObject valueForKey:@"dollarValue"];
    offer.validationRequired = [newManagedObject valueForKey:@"validationRequired"];
    offer.numberOffered = [NSNumber numberWithInt:(int)[newManagedObject valueForKey:@"numberOffered"]];
    offer.startDate = [newManagedObject valueForKey:@"startDate"];
    offer.expirationDate = [newManagedObject valueForKey:@"expirationDate"];
    offer.numberStampsRequired = [NSNumber numberWithInt:(int)[newManagedObject valueForKey:@"numberStampsRequired"]];
    //SAVE new object

    
    
    //Instantiate detail editing controller and push onto stack
    editTableViewController.offer = newManagedObject;
    [self.navigationController pushViewController:editTableViewController animated:YES];    
    
}

- (IBAction)toggleEdit {

    //Editing YES means the table view is currently in editing mode, but is being switched to NOT editing (Note this is reversed from Ch.3 b/c theirs was confusing)
    //??? Should refer to instance variable offersRootTableView or self.tableView here?
    BOOL editing = self.tableView.editing;
    self.navigationItem.rightBarButtonItem.enabled = editing;
    self.navigationItem.leftBarButtonItem.title = (editing) ? NSLocalizedString(@"Edit", @"Edit") : NSLocalizedString(@"Done", "Done");
    //Flip the editing status on the table
    //??? Should refer to instance variable offersRootTableView or self.tableView here?
    [self.tableView setEditing:!editing animated:YES];
}

#pragma mark -
#pragma mark Fetched results controller
/*
 * Note: the Fetched results controller handles setting up, inserting, deleting, and animations thereof
 * 2nd Note: Ch.3 uses "self.tableView" but it is not a TableViewController class (so mine is self.offersRootTableView or self.tableView)
 * ??? Should refer to instance variable offersRootTableView or self.tableView here?
 */
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    Youpon_Pt_2AppDelegate *appDelegate = (Youpon_Pt_2AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    //Entity Description - Offer
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Offer" inManagedObjectContext:managedObjectContext];
    
    //Section key - sorting the section
    NSString *sectionKey = nil;
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"byline" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [sortDescriptor1 release];
    [sortDescriptor2 release];
    [sortDescriptors release];
    sectionKey = @"title";
    
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] 
                                       initWithFetchRequest:fetchRequest 
                                       managedObjectContext:managedObjectContext 
                                       sectionNameKeyPath:sectionKey
                                       cacheName:@"Offer"];
    frc.delegate = self;
    __fetchedResultsController = frc;
    [fetchRequest release];
    
    return __fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            NSString *sectionKeyPath = [controller sectionNameKeyPath];
            if (sectionKeyPath == nil) {
                break;
            }
            NSManagedObject *changedObject = [controller objectAtIndexPath:indexPath];
            NSArray *keyParts = [sectionKeyPath componentsSeparatedByString:@"."];
            id currentKeyValue = [changedObject valueForKeyPath:sectionKeyPath];
            for (int i = 0; i < [keyParts count] - 1; i++) {
                NSString *onePart = [keyParts objectAtIndex:i];
                changedObject = [changedObject valueForKey:onePart];
            }
            sectionKeyPath = [keyParts lastObject];
            NSDictionary *committedValues = [changedObject committedValuesForKeys:nil];
            
            if ([[committedValues valueForKeyPath:sectionKeyPath] isEqual:currentKeyValue]) {
                break;
            }
            
            NSUInteger tableSectionCount = [self.tableView numberOfSections];
            NSUInteger frcSectionCount = [[controller sections] count];
            if (tableSectionCount != frcSectionCount) {
                //Need to insert a section
                NSArray *sections = controller.sections;
                NSInteger newSectionLocation = -1;
                for (id oneSection in sections) {
                    NSString *sectionName = [oneSection name];
                    if ([currentKeyValue isEqual:sectionName]) {
                        newSectionLocation = [sections indexOfObject:oneSection];
                        break;
                    }
                }
                if (newSectionLocation == -1) {
                    return; //this should not happen
                }
                
                if (!(newSectionLocation == 0 && tableSectionCount == 1) && [self.tableView numberOfRowsInSection:0] == 0) {
                    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:newSectionLocation] withRowAnimation:UITableViewRowAnimationFade];
                }
                
                NSUInteger indices[2] = {newSectionLocation, 0};
                newIndexPath = [[[NSIndexPath alloc] initWithIndexes:indices length:2] autorelease];
            }
        }
        case NSFetchedResultsChangeMove:
            if (newIndexPath != nil) {
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            }
            else {
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (!(sectionIndex == 0 && [self.tableView numberOfSections] == 1) && [self.tableView numberOfRowsInSection:0] == 0) {
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        case NSFetchedResultsChangeDelete:
            if (!(sectionIndex == 0 && [self.tableView numberOfSections] == 1) && [self.tableView numberOfRowsInSection:0] == 0) {
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    exit(-1);
}


@end
