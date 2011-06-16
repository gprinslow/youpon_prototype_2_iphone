//
//  ManagedObjectAttributeEditor.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/16/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kNonEditableTextColor [UIColor colorWithRed:0.318 green:0.4 blue:0.569 alpha:1.0]

@interface ManagedObjectAttributeEditor : UITableViewController {
    NSManagedObject *managedObject;
    NSString *keypath;
    NSString *labelString;
}

@property (nonatomic, retain) NSManagedObject *managedObject;
@property (nonatomic, retain) NSString *keypath;
@property (nonatomic, retain) NSString *labelString;

-(IBAction)cancel;
-(IBAction)save;

@end
