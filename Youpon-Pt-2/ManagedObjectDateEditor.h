//
//  ManagedObjectDateEditor.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/16/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedObjectAttributeEditor.h"

@interface ManagedObjectDateEditor : ManagedObjectAttributeEditor {
    UIDatePicker *datePicker;
    UITableView *dateTableView;
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UITableView *dateTableView;

-(IBAction)dateChanged;

@end
