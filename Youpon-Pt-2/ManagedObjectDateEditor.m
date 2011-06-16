//
//  ManagedObjectDateEditor.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/16/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "ManagedObjectDateEditor.h"


@implementation ManagedObjectDateEditor

@synthesize datePicker;
@synthesize dateTableView;

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
    [datePicker release];
    [dateTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//Added: loadView - to create view without a nib
- (void)loadView {
    [super loadView];
    
    //TODO: See if these bounds cause problems!!
    UIView *theView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = theView;
    [theView release];
    
    UITableView *theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 67.0, 320.0, 480.0) style:UITableViewStyleGrouped];
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [self.view addSubview:theTableView];
    self.dateTableView = theTableView;
    [theTableView release];
    
    UIDatePicker *theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, 320.0, 216.0)];
    theDatePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker = theDatePicker;
    [theDatePicker release];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];    
    [self.view addSubview:datePicker];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([managedObject valueForKeyPath:self.keypath] != nil) {
        [self.datePicker setDate:[managedObject valueForKeyPath:keypath] animated:YES];
    }
    else {
        [self.datePicker setDate:[NSDate date] animated:YES];
    }
    
    [self.tableView reloadData];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *GenericManagedObjectDateEditorCell = @"GenericManagedObjectDateEditorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GenericManagedObjectDateEditorCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GenericManagedObjectDateEditorCell] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
        cell.textLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    }
    
    // Configure the cell...
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    cell.textLabel.text = [formatter stringFromDate:[self.datePicker date]];
    [formatter release];
    
    return cell;
}

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
}

#pragma mark - Superclass Overrides
-(IBAction)save {
    [self.managedObject setValue:self.datePicker.date forKey:self.keypath];
    
    NSError *error;
    if (![managedObject.managedObjectContext save:&error]) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Custom Methods
- (IBAction)dateChanged {
    [self.dateTableView reloadData];
}


@end
