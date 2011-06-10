//
//  OffersRootTableViewController.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/5/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "OffersRootTableViewController.h"


@implementation OffersRootTableViewController
@synthesize offersRootTableView;
@synthesize fetchedResultsController=__fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [offersRootTableView release];
    [__fetchedResultsController release];
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
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:NSLocalizedString("Error loading data", "Error loading data") 
                              message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.", @"Error was: %@, quitting."), [error localizedDescription]] 
                              delegate:self 
                              cancelButtonTitle:NSLocalizedString(@"OK, nevermind", @"OK, nevermind")otherButtonTitles:nil];
        [alert show];
    }
    
    //Moved this from viewWillAppear in Ch.3
    //Link edit button to toggleEdit
    UIBarButtonItem *editButton = self.editButtonItem;
    [editButton setTarget:self];
    [editButton setAction:@selector(toggleEdit)];
    self.navigationItem.leftBarButtonItem = editButton;
    
    //Add button
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.offersRootTableView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    static NSString *OfferCellIdentifier = @"OfferCell";
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
    //TODO: Instantiate detail editing controller and push onto stack
}

#pragma mark - Custom methods added - Ch.3

- (void)addOffer {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error saving entity: %@", [error localizedDescription]);
    }
    
    // TODO: Instantiate detail editing controller and push onto stack
}

- (IBAction)toggleEdit {
    //??? Should refer to instance variable offersRootTableView or self.tableView here?
    //Editing YES means the table view is currently in editing mode (Note this is reversed from Ch.3 b/c theirs was confusing)
    BOOL editing = self.offersRootTableView.editing;
    self.navigationItem.rightBarButtonItem.enabled = editing;
    self.navigationItem.leftBarButtonItem.title = (editing) ? NSLocalizedString(@"Edit", @"Edit") : NSLocalizedString(@"Done", "Done");
    //Flip the editing status on the table
    [self.offersRootTableView setEditing:!editing animated:YES];
}

@end
