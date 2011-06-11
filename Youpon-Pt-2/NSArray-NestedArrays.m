//
//  NSArray-NestedArrays.m
//  Youpon-Pt-2
//
//  Created by Garrison on 6/10/11.
//  Copyright 2011 Garrison Prinslow. All rights reserved.
//

#import "NSArray-NestedArrays.h"


@implementation NSArray(NestedArrays)

- (id)nestedObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    NSArray *subArray = [self objectAtIndex:section];
    
    if (![subArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if (row >= [subArray count]) {
        return nil;
    }
    
    return [subArray objectAtIndex:row];
}

- (NSInteger)countOfNestedArray:(NSUInteger)section {
    NSArray *subArray = [self objectAtIndex:section];
    return [subArray count];
}

@end
