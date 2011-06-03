//
//  Youpon_Pt_2AppDelegate.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/2/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffersRootViewController.h"
#import "MapRootViewController.h"
#import "ProfileRootViewController.h"
#import "SettingsRootViewController.h"
#import "LoginRootViewController.h"
#import "ServiceRequest.h"
#import "ServiceResponse.h"
#import "LoginServiceStub.h"



@interface Youpon_Pt_2AppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *rootTabBarController;
    LoginRootViewController *loginRootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootTabBarController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Provided methods - Core Data
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//Custom methods - Service Calls
- (ServiceResponse *)callLoginService:(ServiceRequest *)loginRequest;

@end
