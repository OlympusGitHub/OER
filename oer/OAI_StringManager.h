//
//  OAI_StringManager.h
//  EUS Calculator
//
//  Created by Steve Suranie on 1/9/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAI_StringManager : NSObject {
    
}

@property (nonatomic, retain) NSMutableDictionary* dictAssumptions;
@property (nonatomic, assign) float proceduresPerYear;
@property (nonatomic, retain) NSString* strDisclaimer;
@property (nonatomic, retain) NSString* strNotes;
@property (nonatomic, retain) NSArray* arrChemicalKeys;
@property (nonatomic, retain) NSArray* arrDetergentKeys;
@property (nonatomic, retain) NSArray* arrTestStripsKeys;
@property (nonatomic, retain) NSArray* arrFiltersKeys;
@property (nonatomic, retain) NSArray* arrServiceKeys;
@property (nonatomic, retain) NSArray* arrLaborKeys;
@property (nonatomic, retain) NSArray* arrOperationKeys;
@property (nonatomic, retain) NSArray* arrSections;

+(OAI_StringManager* )sharedStringManager;



@end
