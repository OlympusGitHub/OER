//
//  UIView+GetViewHierarchy.m
//  oer
//
//  Created by Steve Suranie on 6/19/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "UIView+GetViewHierarchy.h"

@implementation UIView (GetViewHierarchy)

- (NSMutableArray*)getViewHierarchy {
    
    NSMutableArray *allSubviews = [NSMutableArray arrayWithObject:self];
    NSArray *subviews = [self subviews];
    for (UIView *view in subviews) {
        [allSubviews addObjectsFromArray:[view getViewHierarchy]];
    }
    return [allSubviews copy];
    
}

@end
