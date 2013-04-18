//
//  OAI_BarChart.h
//  OER
//
//  Created by Steve Suranie on 4/5/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "OAI_ColorManager.h"

#import "OAI_ColorManager.h"


@interface OAI_BarChart : UIView {
    
    OAI_ColorManager* colorManager;
    NSArray* arrColorSets; 
}

- (void) buildBarChart : (int) barCount : (NSArray* ) barData : (NSString*) chartName : (BOOL) hasBorder : (int) barStyle : (NSArray*) arrBarLabels;

- (NSString*) stripSymbols : (NSString* ) stringToClean;

- (NSString*) stripDollarSign : (NSString*) stringToStrip;

@end
