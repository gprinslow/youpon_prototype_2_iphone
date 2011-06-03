//
//  LoginRootViewController.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/3/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "LoginRootViewController.h"
#import "ServiceRequest.h"
#import "ServiceResponse.h"
#import "Youpon_Pt_2AppDelegate.h"

@implementation LoginRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [lblTitle release];
    [lblUsername release];
    [lblPassword release];
    [lblPIN release];
    [lblErrorText release];
    [txfUsername release];
    [txfPassword release];
    [txfPIN release];
    [btnLogin release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [lblTitle release];
    lblTitle = nil;
    [lblUsername release];
    lblUsername = nil;
    [lblPassword release];
    lblPassword = nil;
    [lblPIN release];
    lblPIN = nil;
    [lblErrorText release];
    lblErrorText = nil;
    [txfUsername release];
    txfUsername = nil;
    [txfPassword release];
    txfPassword = nil;
    [txfPIN release];
    txfPIN = nil;
    [btnLogin release];
    btnLogin = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UI Action Methods

- (IBAction)usernameEditingDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
    [txfPassword becomeFirstResponder];
}

- (IBAction)passwordEditingDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
    [txfPIN becomeFirstResponder];
}

- (IBAction)pinEditingDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
    [self doLoginAction:sender];
}

- (IBAction)loginButtonPressed:(id)sender {
    [self doLoginAction:sender];
}

- (IBAction)backgroundTouched:(id)sender {
    [txfUsername resignFirstResponder];
    [txfPassword resignFirstResponder];
    [txfPIN resignFirstResponder];
}

#pragma mark - Action Methods
- doLoginAction:(id)sender {
    
}


@end
