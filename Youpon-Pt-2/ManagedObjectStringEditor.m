//
//  ManagedObjectStringEditor.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/16/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "ManagedObjectStringEditor.h"


@implementation ManagedObjectStringEditor

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
    static NSString *CellIdentifier = @"ManagedObjectStringEditorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        label.textAlignment = UITextAlignmentRight;
        label.tag = kLabelTag;
        UIFont *font = [UIFont boldSystemFontOfSize:14.0];
        label.textColor = kNonEditableTextColor;
        label.font = font;
        [cell.contentView addSubview:label];
        [label release];
        
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 190, 25)];
        
        [cell.contentView addSubview:theTextField];
        theTextField.tag = kTextFieldTag;
        [theTextField release];
    }
    
    // Configure the cell...
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:kLabelTag];
    
    label.text = labelString;
    UITextField *textField = (UITextField *)[cell.contentView viewWithTag:kTextFieldTag];
    NSString *currentValue = [self.managedObject valueForKeyPath:self.keypath];
    
    NSEntityDescription *ed = [self.managedObject entity];
    NSDictionary *properties = [ed propertiesByName];
    NSAttributeDescription *ad = [properties objectForKey:self.keypath];
    NSString *defaultValue = nil;
    
    if (ad != nil) {
        defaultValue = [ad defaultValue];
    }
    if (![currentValue isEqualToString:defaultValue]) {
        textField.text = currentValue;
    }
    
    [textField becomeFirstResponder];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom methods

-(IBAction)save {
    NSUInteger onlyRow[] = {0, 0};
    NSIndexPath *onlyRowPath = [NSIndexPath indexPathWithIndexes:onlyRow length:2];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:onlyRowPath];
    UITextField *textField = (UITextField *)[cell.contentView viewWithTag:kTextFieldTag];
    
    [self.managedObject setValue:textField.text forKey:self.keypath];
    
    NSError *error;
    if (![managedObject.managedObjectContext save:&error]) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
