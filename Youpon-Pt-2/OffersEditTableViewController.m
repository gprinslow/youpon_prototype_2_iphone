//
//  OffersEditTableViewController.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/10/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "OffersEditTableViewController.h"
#import "NSArray-NestedArrays.h"
#import "OfferValueDisplay.h"
#import "ManagedObjectAttributeEditor.h"
#import "OffersRedeemViewController.h"

@implementation OffersEditTableViewController

@synthesize offer;

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
    [offer release];
    [sectionNames release];
    [rowLabels release];
    [rowKeys release];
    [rowControllers release];
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
    
    sectionNames = [[NSArray alloc] initWithObjects:[NSNull null], NSLocalizedString(@"Redeem Offer", @"Redeem Offer"), NSLocalizedString(@"Details", @"Details"), nil];
    
    rowLabels = [[NSArray alloc] initWithObjects:
                 
                 //Section 1
                 [NSArray arrayWithObjects:
                  NSLocalizedString(@"Title", @"Title"), nil],
                 
                 //Section 2
                 [NSArray arrayWithObjects:
                  NSLocalizedString(@"Redeem", @"Redeem"), nil],
                 
                 //Section 3
                 [NSArray arrayWithObjects:
                  NSLocalizedString(@"Byline", @"Byline"),
                  NSLocalizedString(@"Category", @"Category"),
                  NSLocalizedString(@"Start Date", @"Start Date"),
                  NSLocalizedString(@"Expiration Date", @"Expiration Date"),
                  nil],
                 
                 //Sentinel
                 nil];
    
    rowKeys = [[NSArray alloc] initWithObjects:
               
               //Section 1
               [NSArray arrayWithObjects:@"title", nil],
               
               //Section 2
               [NSArray arrayWithObjects:@"redeemButton", nil],
               
               //Section 3
               [NSArray arrayWithObjects:@"byline", @"category", @"startDate", @"expirationDate", nil],
               
               //Sentinel
               nil];
    
    //Populate rowControllers array
    rowControllers = [[NSArray alloc] initWithObjects:
                      //Section 1
                      [NSArray arrayWithObject:@"ManagedObjectStringEditor"],
                      
                      //Section 2
                      [NSArray arrayWithObject:[NSNull null]],
                      
                      //Section 3
                      [NSArray arrayWithObjects:
                       @"ManagedObjectStringEditor",
                       @"ManagedObjectSingleSelectionListEditor",
                       @"ManagedObjectDateEditor",
                       @"ManagedObjectDateEditor",
                       nil],
                      
                      //Sentinel
                      nil];
    
    rowArguments = [[NSArray alloc] initWithObjects:
                    //Section 1
                    [NSArray arrayWithObject:[NSNull null]],
                    
                    //Section 2
                    [NSArray arrayWithObject:[NSNull null]],
                    
                    //Section 3
                    [NSArray arrayWithObjects:
                     [NSNull null],
                     [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"Coffee", @"Entertainment", @"Food", @"Haircuts", nil] forKey:@"list"],
                     [NSNull null],
                     nil],
                    
                    //Sentinel
                    nil];
    
    
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
    
    //Added - according to online Ch.4 typos
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
    return [sectionNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [rowLabels countOfNestedArray:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OfferEditCellIdentifier = @"OfferEditCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OfferEditCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:OfferEditCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSString *rowKey = [rowKeys nestedObjectAtIndexPath:indexPath];
    NSString *rowLabel = [rowLabels nestedObjectAtIndexPath:indexPath];
    
    if ([rowKey isEqualToString:@"redeemButton"]) {
        cell.textLabel.text = rowLabel;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Only %@ left!", [offer valueForKey:@"numberOffered"]];
        
        UIButton *redeemButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [redeemButton addTarget:self action:@selector(redeemOffer) forControlEvents:UIControlEventTouchUpInside];
        [redeemButton setTitle:@"Redeem Now" forState:UIControlStateNormal];

        redeemButton.frame = CGRectMake(200.0f, 4.0f, 110.0f, 30.0f);
        
        cell.accessoryView = redeemButton;
    }
    else {
        id <OfferValueDisplay, NSObject> rowValue = [offer valueForKey:rowKey];
             
        cell.detailTextLabel.text = [rowValue offerValueDisplay];
        cell.textLabel.text = rowLabel;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    
    //Push editing controller onto the stack
    NSString *controllerClassName = [rowControllers nestedObjectAtIndexPath:indexPath];
    NSString *rowLabel = [rowLabels nestedObjectAtIndexPath:indexPath];
    NSString *rowKey = [rowKeys nestedObjectAtIndexPath:indexPath];
    
    if ([rowKey isEqualToString:@"redeemButton"]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self redeemOffer];
    }
    else {
            
        Class controllerClass = NSClassFromString(controllerClassName);
        ManagedObjectAttributeEditor *controller = [controllerClass alloc];
        controller = [controller initWithStyle:UITableViewStyleGrouped];
        controller.keypath = rowKey;
        controller.managedObject = offer;
        controller.labelString = rowLabel;
        controller.title = rowLabel;
        
        NSDictionary *args = [rowArguments nestedObjectAtIndexPath:indexPath];
        if ([args isKindOfClass:[NSDictionary class]]) {
            if (args != nil) {
                for (NSString *oneKey in args) {
                    id oneArg = [args objectForKey:oneKey];
                    [controller setValue:oneArg forKey:oneKey];
                }
            }
        }
        
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
    }
}

#pragma mark - Table view - added methods (Ch. 4)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id title = [sectionNames objectAtIndex:section];
    if ([title isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return title;
}

#pragma mark - Custom methods
-(IBAction)redeemOffer {
    OffersRedeemViewController *redeemViewController = [[OffersRedeemViewController alloc] initWithNibName:@"OffersRedeemView" bundle:nil];
    
    [redeemViewController setOffer:offer];
    
    [self.navigationController pushViewController:redeemViewController animated:YES];
    
    [redeemViewController release];
}


@end
