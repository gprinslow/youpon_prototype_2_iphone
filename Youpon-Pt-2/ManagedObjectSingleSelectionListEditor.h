//
//  ManagedObjectSingleSelectionListEditor.h
//  Youpon-Pt-2
//
//  Created by Garrison on 6/16/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedObjectAttributeEditor.h"

@interface ManagedObjectSingleSelectionListEditor : ManagedObjectAttributeEditor {
    NSArray *list;
    
    @private
    NSIndexPath *lastIndexPath;
}

@property (nonatomic, retain) NSArray *list;

@end
