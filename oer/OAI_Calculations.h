//
//  OAI_Calculations.h
//  OER
//
//  Created by Steve Suranie on 4/3/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAI_TextField.h"
#import "NSString-StripNonNumerics.h"

@interface OAI_Calculations : NSObject

@property (nonatomic, retain) NSMutableDictionary* dictResults;
@property (nonatomic, retain) NSMutableDictionary* dictTextFields;
@property (nonatomic, retain) NSMutableDictionary* dictAssumptions;
@property (nonatomic, retain) NSMutableDictionary* dictInitialValues;
@property (nonatomic, assign) BOOL isOpening;

- (void) calculate : (BOOL) showResults : (NSString*) strCalculateWhat;

- (void) calculateSection : (NSString*) strThisSection : (OAI_TextField*) txtThisField : (NSString*) strThisKey : (NSString*) strThisDicount;

- (float) getDiscount : (OAI_TextField*) textField; 

- (float) calculateDiscounts : (float) discount : (float) appliedTo;

- (float) calculateEstimatedOperationalCost : (float) customPrice : (float) unitsPerCase : (float) unitsRecommendedForOperation;

- (float) calculateCostPerCycle : (float) estimatedOperatingCost : (float) estimatedNumberOfCycles;

- (float) calculateCostPerScope : (float) myScopesPerBasin : (float) costPerCycle;

- (NSArray*) calculateFiltersCost : (float) myFilterDiscount : (float) myOERCount : (float) myCyclesPerYear : (float) myScopesPerBasin;

- (NSArray*) calculateServiceCost : (float) myServiceDiscount : (float) myCyclesPerYear : (float) myScopesPerBasin;

- (NSString*) clearDollarSymbol : (NSString*) stringToClean;

- (NSString*) convertToCurrencyString : (NSDecimalNumber*) numberToConvert;

@end
