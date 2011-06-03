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


@interface Youpon_Pt_2AppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *rootTabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootTabBarController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
