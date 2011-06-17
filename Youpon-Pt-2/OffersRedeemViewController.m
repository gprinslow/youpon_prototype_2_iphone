//
//  OffersRedeemViewController.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/17/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "OffersRedeemViewController.h"
#import "RedeemServiceRequest.h"
#import "RedeemServiceResponse.h"
#import "Youpon_Pt_2AppDelegate.h"

@implementation OffersRedeemViewController

@synthesize offer;
@synthesize actValidatingActivityIndicator;
@synthesize lblValidatingStatusMessage;
@synthesize lblSuccessMessage;
@synthesize lblSuccessDetailMessage;
@synthesize lblFailureMessage;
@synthesize lblFailureDetailMessage;
@synthesize lblBackMessage;

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
    [actValidatingActivityIndicator release];
    [lblValidatingStatusMessage release];
    [lblSuccessMessage release];
    [lblSuccessDetailMessage release];
    [lblFailureMessage release];
    [lblFailureDetailMessage release];
    [lblBackMessage release];
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

    [super viewDidLoad];
    
    [self doRedeemAction:self];
}


- (void)viewDidUnload
{
    [self setActValidatingActivityIndicator:nil];
    [self setLblValidatingStatusMessage:nil];
    [self setLblSuccessMessage:nil];
    [self setLblSuccessDetailMessage:nil];
    [self setLblFailureMessage:nil];
    [self setLblFailureDetailMessage:nil];
    [self setLblBackMessage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom methods
- doRedeemAction:(id)sender {
    [actValidatingActivityIndicator setHidden:NO];
    [actValidatingActivityIndicator startAnimating];
    
    //Simulate delay
    for (int i=0; i<100; i++) {
        NSLog(@"Simulating delay");
    }
    

    [lblSuccessMessage setHidden:YES];
    [lblSuccessDetailMessage setHidden:YES];
    [lblFailureMessage setHidden:YES];
    [lblFailureDetailMessage setHidden:YES];
    [lblBackMessage setHidden:YES];
    
    RedeemServiceRequest *redeemRequest = [[RedeemServiceRequest alloc] init];
    RedeemServiceResponse *redeemResponse = [[RedeemServiceResponse alloc] init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [redeemRequest setRequestTime:[NSDate date]];
    [redeemRequest setRequestType:@"REDEEM"];
    [redeemRequest setRequestorUsername:[userDefaults objectForKey:@"authenticatedUsername"]];
    [redeemRequest setRequestorPassword:[userDefaults objectForKey:@"authenticatedPassword"]];
    [redeemRequest setOffer:offer];
    
    Youpon_Pt_2AppDelegate *appDelegate = (Youpon_Pt_2AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    redeemResponse = [appDelegate callRedeemService:redeemRequest];
    
    if ([[redeemResponse responseCode] isEqualToString:@"SUCCESS"]) {
        lblSuccessDetailMessage.text = [redeemResponse responseDetail];
        
        [lblSuccessMessage setHidden:NO];
        [lblSuccessDetailMessage setHidden:NO];
        [lblBackMessage setHidden:NO];
        
        [actValidatingActivityIndicator stopAnimating];
        [actValidatingActivityIndicator setHidden:YES];
    }
    else if ([[redeemResponse responseCode] isEqualToString:@"FAILURE"]) {
        lblFailureDetailMessage.text = [redeemResponse responseDetail];
        
        [lblFailureMessage setHidden:NO];
        [lblFailureDetailMessage setHidden:NO];
        [lblBackMessage setHidden:NO];
        
        [actValidatingActivityIndicator stopAnimating];
        [actValidatingActivityIndicator setHidden:YES];
    }
    
    
    [redeemRequest release];
    [redeemResponse release];
    
    return 0;
}


@end
