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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [lblErrorText setText:@""];
    
    //Get user defaults to determine additional UI settings
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *hasAuthenticated = [userDefaults objectForKey:@"hasAuthenticated"];
    NSString *authenticatedUsername = [userDefaults objectForKey:@"authenticatedUsername"];
    NSString *authenticatedPassword = [userDefaults objectForKey:@"authenticatedPassword"];
    
    if ([hasAuthenticated isEqualToString:@"TRUE"]) {
        [txfUsername setText:authenticatedUsername];
        [txfPassword setText:authenticatedPassword];
        
        [txfUsername setEnabled:FALSE];
        [txfPassword setEnabled:FALSE];
    }
    else if ([hasAuthenticated isEqualToString:@"NOPIN"]) {
        //Do nothing
    }
    else if ([hasAuthenticated isEqualToString:@"FALSE"]) {
        //Do nothing
    }
    
    [super viewDidLoad];
}


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
    [txfUsername resignFirstResponder];
    [txfPassword resignFirstResponder];
    [txfPIN resignFirstResponder];
    [self doLoginAction:sender];
}

- (IBAction)backgroundTouched:(id)sender {
    [txfUsername resignFirstResponder];
    [txfPassword resignFirstResponder];
    [txfPIN resignFirstResponder];
}

#pragma mark - Action Methods
- doLoginAction:(id)sender {
    //Reset colors
    [txfUsername setTextColor:[UIColor blackColor]];
    [txfPassword setTextColor:[UIColor blackColor]];
    [txfPIN setTextColor:[UIColor blackColor]];
    
    //Init ServiceRequest/Response
    ServiceRequest *loginRequest = [[ServiceRequest alloc] init];
    ServiceResponse *loginResponse = [[ServiceResponse alloc] init];
    
    //Set up Login Request
    [loginRequest setRequestTime:[NSDate date]];
    [loginRequest setRequestType:@"LOGIN"];
    [loginRequest setRequestorUsername:[txfUsername text]];
    [loginRequest setRequestorPassword:[txfPassword text]];
    
    //Get ref to App Delegate
    Youpon_Pt_2AppDelegate *appDelegate = (Youpon_Pt_2AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Call service - get service response
    loginResponse = [appDelegate callLoginService:loginRequest];
    
    //Get user defaults to determine flow
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *hasAuthenticated = [userDefaults objectForKey:@"hasAuthenticated"];
    NSString *authenticatedPIN = [userDefaults objectForKey:@"authenticatedPIN"];
    
    BOOL goToMainMenu = FALSE;

    if ([hasAuthenticated isEqualToString:@"FALSE"] || [hasAuthenticated isEqualToString:@"NOPIN"] || hasAuthenticated == NULL) {
        if ([[loginResponse responseCode] isEqualToString:@"SUCCESS"]) {
            if (![[txfPIN text] isEqualToString:@""]) {
                [userDefaults setObject:@"TRUE" forKey:@"hasAuthenticated"];
                [userDefaults setObject:[txfUsername text] forKey:@"authenticatedUsername"];
                [userDefaults setObject:[txfPassword text] forKey:@"authenticatedPassword"];
                [userDefaults setObject:[txfPIN text] forKey:@"authenticatedPIN"];
                goToMainMenu = TRUE;
            }
            else {
                [userDefaults setObject:@"NOPIN" forKey:@"hasAuthenticated"];
                [userDefaults setObject:[txfUsername text] forKey:@"authenticatedUsername"];
                [userDefaults setObject:[txfPassword text] forKey:@"authenticatedPassword"];
                goToMainMenu = TRUE;
            }
        }
        else if ([[loginResponse responseCode] isEqualToString:@"INVALID_USERNAME"]) {
            [userDefaults setObject:@"FALSE" forKey:@"hasAuthenticated"];
            
            [txfUsername setTextColor:[UIColor redColor]];
            [lblErrorText setText:@"Username is not recognized"];
            NSLog(@"Invalid login attempt - Invalid username");
        }
        else if ([[loginResponse responseCode] isEqualToString:@"INVALID_PASSWORD"]) {
            [userDefaults setObject:@"FALSE" forKey:@"hasAuthenticated"];
            
            [txfPassword setTextColor:[UIColor redColor]];
            [lblErrorText setText:@"Password does not match"];
            NSLog(@"Invalid login attempt - Invalid password for this username");
        }
    }
    else if ([hasAuthenticated isEqualToString:@"TRUE"]) {
        if ([[txfPIN text] isEqualToString:authenticatedPIN]) {
            [userDefaults setObject:@"TRUE" forKey:@"hasAuthenticated"];
            
            goToMainMenu = TRUE;
        }
        else {
            [userDefaults setObject:@"FALSE" forKey:@"hasAuthenticated"];
            
            [txfPIN setTextColor:[UIColor redColor]];
            [lblErrorText setText:@"PIN does not match"];
            NSLog(@"Invalid login attempt - PIN does not match");
        }
    }
    else {
        NSLog(@"Invalid login attempt - unrecognized Authentication status: %@", hasAuthenticated);
    }
    //Save userdefaults
    [userDefaults synchronize];
    
    [loginRequest release];
    loginRequest = nil;
    [loginResponse release];
    loginResponse = nil;
    
    if (goToMainMenu) {
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    }
    return 0;
}


@end
