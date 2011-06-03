//
//  LoginRootViewController.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/3/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginRootViewController : UIViewController {
    //UI Outlets
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblUsername;
    IBOutlet UILabel *lblPassword;
    IBOutlet UILabel *lblPIN;
    IBOutlet UILabel *lblErrorText;
    IBOutlet UITextField *txfUsername;
    IBOutlet UITextField *txfPassword;
    IBOutlet UITextField *txfPIN;
    IBOutlet UIButton *btnLogin;
}

//UI Action Methods
- (IBAction)usernameEditingDidEndOnExit:(id)sender;
- (IBAction)passwordEditingDidEndOnExit:(id)sender;
- (IBAction)pinEditingDidEndOnExit:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

//Action Methods
- doLoginAction:(id)sender;

@end
