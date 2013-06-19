//
//  OAI_Calculations.m
//  OER
//
//  Created by Steve Suranie on 4/3/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_Calculations.h"

@implementation OAI_Calculations

- (void) calculate : (BOOL) showResults : (NSString*) strCalculateWhat {
    
    /*
     Legend:
     LP = List Price
     CP = Custom Price (Purchase Price) = List Price * Discount
     EOC = Estimated Operating Cost = (customPrice/unitsPerCase)*unitsRecommendedForOperation
     UPC = Units Per Case - from assumptions
     URFO = Units Required For Operation - from assumptions
     ENC = Estimated Number of Cycles (Maximum) - from assumptions
     CPS = Cost Per Scope = Cost Per Cycle/Scopes Per Basin
     CPC = Cost Per Cycle = EOC/ENC
     
     numeric type 0=int, 1=%, 2=$, 3=decimal
     */
    
    /*
     for(NSString* strThisKey in _dictTextFields) {
        NSLog(@"%@", strThisKey);
    }
     */
    
    
    //determine what we are calculating
    BOOL doChemicals = NO;
    BOOL doOthers = NO;
    BOOL doLabor = NO;
    BOOL doService = NO;
    
    if([strCalculateWhat isEqualToString:@"Chemicals"]) {
        doChemicals = YES;
    } else if ([strCalculateWhat isEqualToString:@"Others"]) {
        doOthers = YES;
    } else if ([strCalculateWhat isEqualToString:@"Labor"]) {
        doLabor = YES;
    } else if ([strCalculateWhat isEqualToString:@"Service"]) {
        doService = YES;
    } else {
        doChemicals = YES;
        doOthers = YES;
        doLabor = YES;
        doService = YES;
    }
    
    //init dictionary to hold our return values
      _dictResults = [[NSMutableDictionary alloc] init];
    
    //set the number of OERs needed
    OAI_TextField* txtProcedureCount = [_dictTextFields objectForKey:@"Procedure Count"];
    float procedureCount = [txtProcedureCount.text floatValue];
    float OERCount = roundf(procedureCount/2000);
    int intOERCount = (int)OERCount;
    [_dictResults setObject:[NSString stringWithFormat:@"%i", intOERCount] forKey:@"OER Count"];
    
    //set the estimated cycles per year
    OAI_TextField* txtScopesPerBasin = [_dictTextFields objectForKey:@"Scopes Per Basin"];
    float scopesPerBasin = [txtScopesPerBasin.text floatValue];
    float cyclesPerYear = roundf(procedureCount/scopesPerBasin);
    int intCyclesPerYear = (int)cyclesPerYear;
    
    [_dictResults setObject:[NSString stringWithFormat:@"%.02f", scopesPerBasin] forKey:@"Scopes Per Basin"];
    [_dictResults setObject:[NSString stringWithFormat:@"%i", intCyclesPerYear] forKey:@"Annual Cycle Count"];
        
    //get textfield values - work with float/doubles then convert everything to required numeric type
    OAI_TextField* txtThisField;
    
    
    NSString* strThisDiscount;
    
    for(NSString* strThisKey in _dictTextFields) {
        
        //get the text field
        if ([[_dictTextFields objectForKey:strThisKey] isMemberOfClass:[OAI_TextField class]]) {
            txtThisField = [_dictTextFields objectForKey:strThisKey];
        }
                
        if (doChemicals) {
            
            //get the chemical discount
            if ([strThisKey rangeOfString:@"Chemicals"].location != NSNotFound) {
                
                //include the discount and compeition text fields
                if([strThisKey rangeOfString:@"Discount"].location != NSNotFound || [strThisKey rangeOfString:@"Competition"].location != NSNotFound) {
                    
                    //get the discount
                    if([strThisKey rangeOfString:@"Discount"].location != NSNotFound) { 
                        strThisDiscount = txtThisField.text;
                    }
                    
                    [self calculateSection:@"Chemicals":txtThisField:strThisKey:strThisDiscount];
                }
            }
        }
        
        if (doOthers) {
            
            //get discount
            if ([strThisKey rangeOfString:@"Detergents"].location != NSNotFound) {
                
                //include the discount and compeition text fields
                if([strThisKey rangeOfString:@"Discount"].location != NSNotFound || [strThisKey rangeOfString:@"Competition"].location != NSNotFound) {
                
                    //get the discount
                    if([strThisKey rangeOfString:@"Discount"].location != NSNotFound) {
                        strThisDiscount = txtThisField.text;
                    }

                    [self calculateSection:@"Detergents":txtThisField:strThisKey:strThisDiscount];
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Test Strips"].location != NSNotFound) {
                
                //include the discount and compeition text fields
                if([strThisKey rangeOfString:@"Discount"].location != NSNotFound || [strThisKey rangeOfString:@"Competition"].location != NSNotFound) {
                    
                    //get the discount
                    if([strThisKey rangeOfString:@"Discount"].location != NSNotFound) {
                        strThisDiscount = txtThisField.text;
                    }

                    [self calculateSection:@"Test Strips":txtThisField:strThisKey:strThisDiscount];
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Filters"].location != NSNotFound) {
                
                //include the discount and compeition text fields
                if([strThisKey rangeOfString:@"Discount"].location != NSNotFound || [strThisKey rangeOfString:@"Competition"].location != NSNotFound) {
                    
                    //get the discount
                    if([strThisKey rangeOfString:@"Discount"].location != NSNotFound) {
                        strThisDiscount = txtThisField.text;
                    }
                    
                    [self calculateSection:@"Filters":txtThisField:strThisKey:strThisDiscount];
                    
                }
                
            }
            
        }
        
        if (doLabor) {
            if ([strThisKey rangeOfString:@"Labor"].location != NSNotFound) {
                [self calculateSection:@"Labor":txtThisField:strThisKey:strThisDiscount];
            }
        }
        
        if (doService) { 
            if ([strThisKey rangeOfString:@"Service"].location != NSNotFound) {
                [self calculateSection:@"Service":txtThisField:strThisKey:strThisDiscount];
            }
        }

    }
    
    //operation time
    for(NSString* strThisKey in _dictTextFields) {
        
        if ([strThisKey rangeOfString:@"Operation Time"].location !=NSNotFound) {
            
            //ALDAHOL
            [_dictResults setObject:@"2 " forKey:@"Operation Time_Pre-Cleaning_ALDAHOL"];
            [_dictResults setObject:@"4 " forKey:@"Operation Time_Leakage Testing_ALDAHOL"];
            [_dictResults setObject:@"3 " forKey:@"Operation Time_Manual Cleaning_ALDAHOL"];
            [_dictResults setObject:@"29 " forKey:@"Operation Time_Post AER Processing_ALDAHOL"];
            [_dictResults setObject:@"3 " forKey:@"Operation Time_AER Processing_ALDAHOL"];
            
            //AcecideC
            [_dictResults setObject:@"2 " forKey:@"Operation Time_Pre-Cleaning_AcecideC"];
            [_dictResults setObject:@"4 " forKey:@"Operation Time_Leakage Testing_AcecideC"];
            [_dictResults setObject:@"3 " forKey:@"Operation Time_Manual Cleaning_AcecideC"];
            [_dictResults setObject:@"26 " forKey:@"Operation Time_Post AER Processing_AcecideC"];
            [_dictResults setObject:@"3 " forKey:@"Operation Time_AER Processing_AcecideC"];
            
            //Competition
            OAI_TextField* txtAERProcessing = [_dictTextFields objectForKey:@"Operation Time_AER Processing_Competition"];
            OAI_TextField* txtLeakageTesting = [_dictTextFields objectForKey:@"Operation Time_Leakage Testing_Competition"];
            OAI_TextField* txtManualCleaning = [_dictTextFields objectForKey:@"Operation Time_Manual Cleaning_Competition"];
            OAI_TextField* txtAERPostCleaning = [_dictTextFields objectForKey:@"Operation Time_Post AER Processing_Competition"];
            OAI_TextField* txtPreCleaning = [_dictTextFields objectForKey:@"Operation Time_Pre-Cleaning_Competition"];
            
            NSString* strAERProcessing;
            NSString* strLeakageTesting;
            NSString* strManualCleaning;
            NSString* strAERPostCleaning;
            NSString* strPreCleaning;
            
            if (txtAERProcessing.text != nil) {
                strAERProcessing = txtAERProcessing.text;
            } else {
                strAERProcessing = @"0";
            }
            
            if (txtLeakageTesting.text != nil) {
                strLeakageTesting = txtLeakageTesting.text;
            } else {
                strLeakageTesting = @"0";
            }
            
            if (txtManualCleaning.text != nil) {
                strManualCleaning = txtManualCleaning.text;
            } else {
                strManualCleaning = @"0";
            }
            
            if (txtAERPostCleaning.text != nil) {
                strAERPostCleaning = txtAERPostCleaning.text;
            } else {
                strAERPostCleaning = @"0";
            }
            
            if (txtPreCleaning.text != nil) {
                strPreCleaning = txtPreCleaning.text;
            } else {
                strPreCleaning = @"0";
            }
            
            
            [_dictResults setObject:strPreCleaning forKey:@"Operation Time_Pre-Cleaning_Competition"];
            [_dictResults setObject:strLeakageTesting forKey:@"Operation Time_Leakage Testing_Competition"];
            [_dictResults setObject:strManualCleaning forKey:@"Operation Time_Manual Cleaning_Competition"];
            [_dictResults setObject:strAERPostCleaning forKey:@"Operation Time_Post AER Processing_Competition"];
            [_dictResults setObject:strAERProcessing forKey:@"Operation Time_AER Processing_Competition"];
            
        } else if ([strThisKey rangeOfString:@"Labor_Additional"].location !=NSNotFound) {
            
            OAI_TextField* txtThisLabor = [_dictTextFields objectForKey:strThisKey];
            
            //convert to a float
            NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
            [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
            NSNumber* number = [nf numberFromString:txtThisLabor.text];
            
            float laborCAS = [number floatValue];
            float laborCPS = (laborCAS/cyclesPerYear)/scopesPerBasin;
            
            //ALDAHOL Labor
            //set the ALDAHOL values
            if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCAS] forKey:@"Labor_Additional Cost Above Service_ALDAHOL"];
                [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCPS] forKey:@"Labor_Labor Cost Per Scope_ALDAHOL"];
            } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
                //AcecideC Labor
                [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCAS] forKey:@"Labor_Additional Cost Above Service_AcecideC"];
                [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCPS] forKey:@"Labor_Labor Cost Per Scope_AcecideC"];
                
            }
            
        } else if ([strThisKey rangeOfString:@"Labor_Labor Cost Per Scope_Competition"].location !=NSNotFound) {
            //Competition Labor
            
            //set the Labor cost for competition
            OAI_TextField* txtCostPerScope = [_dictTextFields objectForKey:@"Labor_Labor Cost Per Scope_Competition"];
            NSString* strLaborCompCPS = txtCostPerScope.text;
            
            //check to make sure result is not nil
            if (strLaborCompCPS == nil) {
                strLaborCompCPS = @"$0.0";
            }
            
            //[_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCAS] forKey:@"Labor_Additional Cost Above Service_Competition"];
            [_dictResults setObject:strLaborCompCPS forKey:@"Labor_Labor Cost Per Scope_Competition"];
        }
        
    }

    
    
    //get those results based on base and textfield values, place into dictionary
    
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    _dictInitialValues = [[NSMutableDictionary alloc] init];
    
    if (_isOpening) {
        _dictInitialValues = _dictResults;
    }
    
    //return dictionary of results
    [userData setObject:_dictResults forKey:@"Results"];
    [userData setObject:@"Show Results" forKey:@"Action"];
    
    //This is the call back to the notification center,
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];

        
}

- (void) calculateSection : (NSString*) strThisSection : (OAI_TextField*) txtThisField : (NSString*) strThisKey : (NSString*) strThisDiscount {
   
    //these are the assumptions provided in the excel sheet    
    
    //list prices
    float ALDAHOL_LP = 115.00;
    float Comply_Strips_LP = 105.00;
    float Acecide_Test_Strips_LP = 90.00;
    float AcecideC_LP = 990.00;
    float EndoQuick_LP = 100.0;
    
    BOOL isALDAHOL = NO;
    BOOL isAcecide = NO;
    BOOL isCompetition = NO;
    
    //values needed to be displayed
    float thisDiscount = [strThisDiscount floatValue];
    float thisCP = 0.0;
    float thisEOC = 0.0;
    float thisUPC = 0.0;
    float thisURFO = 0.0;
    float thisENC = 0.0;
    float thisCPC = 0.0;
    float thisCPS = 0.0;
    float thisLP = 0.0;
    
    NSString* strKeySuffix;
    NSString* strKeyPrefix;
    NSString* strThisSectionPlural;
    NSString* strLaborCPSKey;
    
    //get our base numbers
    float cyclesPerYear = [[_dictResults objectForKey:@"Annual Cycle Count"] floatValue];
    float OERCount = [[_dictResults objectForKey:@"OER Count"] floatValue];
    float scopesPerBasin = [[_dictResults objectForKey:@"Scopes Per Basin"] floatValue];
    
    //set section and section values
    if([strThisSection isEqualToString:@"Chemicals"]) {
        strThisSectionPlural = @"Chemicals";
        strThisSection = @"Chemical";
        //pricing is different for ALDAHOL and Acecide
        if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
            thisLP = ALDAHOL_LP;
            thisUPC = 4;
            thisURFO = 5;
            thisENC = 17;
        } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
            thisLP = AcecideC_LP;
            thisUPC = 6;
            thisURFO = 1;
            thisENC = 18;
        }
    } else if ([strThisSection isEqualToString:@"Detergents"]) {
        strThisSectionPlural = @"Detergents";
        strThisSection = @"Detergent";
        thisUPC = 3;
        thisURFO = 1;
        thisENC = 30;
        thisLP = 95.00;
    } else if ([strThisKey rangeOfString:@"Test Strips"].location !=NSNotFound) {
        strThisSection = @"Test Strip";
        strThisSectionPlural = @"Test Strips";
        if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
            thisUPC = 12;
            thisURFO = 1;
            thisENC = 1;
            thisLP = 99.75;
        } else if ([strThisKey rangeOfString:@"AcecideC"].location !=NSNotFound) {
            thisUPC = 100;
            thisURFO = 1;
            thisENC = 1;
            thisLP = 85.50;
        }
    } else if ([strThisKey rangeOfString:@"Filters"].location !=NSNotFound) {
        strThisSection = @"Filter";
        strThisSectionPlural = @"Filters";
    } else if ([strThisKey rangeOfString:@"Labor"].location !=NSNotFound) {
        //get value and determine what we are working with
        if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
            isALDAHOL = YES;
            strLaborCPSKey = @"Labor_Labor Cost Per Scope_ALDAHOL";
        } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
            isAcecide = YES;
            strLaborCPSKey = @"Labor_Labor Cost Per Scope_AcecideC";
        } else if ([strThisKey rangeOfString:@"Competition"].location !=NSNotFound) {
            isCompetition = YES;
            strLaborCPSKey = @"Labor_Labor Cost Per Scope_Competition";
        }
    }
    
    //set product properties
    if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
        isALDAHOL = YES;
        strKeySuffix = @"_ALDAHOL";
        strKeyPrefix = @"ALDAHOL";
    } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
        isAcecide = YES;
        strKeySuffix = @"_AcecideC";
        strKeyPrefix = @"Acecide";
    } else if ([strThisKey rangeOfString:@"Competition"].location !=NSNotFound) {
        isCompetition = YES;
        strKeySuffix = @"_Competition";
        strKeyPrefix = @"Competition";
        
    }
    
    if (!isCompetition) {
        
        if ([strThisSection isEqualToString:@"Detergent"] || [strThisSection isEqualToString:@"Chemical"] || [strThisSection isEqualToString:@"Test Strip"]) { 
            
            //get custom pricing
            thisCP = [self calculateDiscounts:[strThisDiscount floatValue]:thisLP];
            
            //get EOC Formula:(CP/UPC)*URFO
            thisEOC = [self calculateEstimatedOperationalCost:thisCP :thisUPC :thisURFO];
            
            //get cost per cylce - UPC/ENC
            thisCPC = [self calculateCostPerCycle:thisEOC:thisENC];
            
            //get cost per scope
            thisCPS = [self calculateCostPerScope:scopesPerBasin :thisCPC];
            
            //store results
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisDiscount] forKey:[NSString stringWithFormat:@"%@_Discount%@", strThisSectionPlural, strKeySuffix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisUPC] forKey:[NSString stringWithFormat:@"%@_Units Per Package%@", strThisSectionPlural, strKeySuffix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisCP] forKey:[NSString stringWithFormat:@"%@_Purchase Price (per case)%@", strThisSectionPlural, strKeySuffix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisENC] forKey:[NSString stringWithFormat:@"%@_Maximum Use Life (# cycles per basin)%@", strThisSectionPlural, strKeySuffix ]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisEOC] forKey:[NSString stringWithFormat:@"%@ %@ Estimated Operational Cost", strThisSection, strKeyPrefix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisCPC] forKey:[NSString stringWithFormat:@"%@ %@ Cost Per Cycle", strThisSection, strKeyPrefix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisCPS] forKey:[NSString stringWithFormat:@"%@_%@ Cost Per Scope%@", strThisSectionPlural, strThisSection, strKeySuffix]];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisURFO] forKey:[NSString stringWithFormat:@"%@_Units Required For Operation (per basin)%@", strThisSectionPlural, strKeySuffix]];
            
        } else if ([strThisSection isEqualToString:@"Filter"]) {
           
            //get the filter cost
            NSArray* arrFiltersCost = [self calculateFiltersCost:thisDiscount:OERCount:cyclesPerYear:scopesPerBasin];
            
            //pull the results
            NSString* strFilterCP = [arrFiltersCost objectAtIndex:0];
            NSString* strFilterCPS = [arrFiltersCost objectAtIndex:1];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisDiscount] forKey:[NSString stringWithFormat:@"Filters_Discount%@", strKeySuffix]];
            [_dictResults setObject:strFilterCP forKey:[NSString stringWithFormat:@"Filters_Annual Cost%@", strKeySuffix]];
            [_dictResults setObject:strFilterCPS forKey:[NSString stringWithFormat:@"Filters_Filter Cost Per Scope%@", strKeySuffix]];
            
        } else if ([strThisSection isEqualToString:@"Labor"]) {
            
            NSString* strLaborCost;
            
            if ([txtThisField.textFieldTitle isEqualToString:@"Labor_Additional Cost Above Service_ALDAHOL"] || [txtThisField.textFieldTitle isEqualToString:@"Labor_Additional Cost Above Service_AcecideC"]) {
                
                strLaborCost = txtThisField.text;
                
                if(!strLaborCost) {
                    strLaborCost = @"0.0";
                }
                
                //formula = (cycles per year/labor cost)/scopes per basin
                float laborCost = [strLaborCost floatValue];
                float laborCPS = 0.0;
                
                if (laborCost !=0) { 
                    laborCPS = (cyclesPerYear/laborCost)/scopesPerBasin;
                }
                
                //store the data
                [_dictResults setObject:[NSString stringWithFormat:@"%f", laborCost] forKey:[NSString stringWithFormat:@"Labor_Additional Cost Above Service%@", strKeySuffix]];
                [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCPS] forKey:[NSString stringWithFormat:@"Labor_Labor Cost Per Scope_%@", strKeySuffix]];
                
            }
            

            
        } else if ([strThisSection isEqualToString:@"Service"]) {
            
            NSArray* arrServiceCost = [self calculateServiceCost:thisDiscount:cyclesPerYear:scopesPerBasin];
            
            NSString* strServiceCP = [arrServiceCost objectAtIndex:0];
            NSString* strServiceCPS = [arrServiceCost objectAtIndex:1];
            
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", thisDiscount] forKey:[NSString stringWithFormat:@"Service_Discount%@", strKeySuffix]];
            [_dictResults setObject:strServiceCP forKey:[NSString stringWithFormat:@"Service_Annual Cost%@", strKeySuffix]];
            [_dictResults setObject:strServiceCPS forKey:[NSString stringWithFormat:@"Service_Service Cost Per Scope%@", strKeySuffix]];

            
        }
        
    } else {
        
        
        if ([strThisKey rangeOfString:@"Cost Per Scope"].location != NSNotFound) {
            
            NSString* strThisValue = txtThisField.text;
            
            if (!strThisValue) {
                strThisValue = @"0.00";
            }
            
            //strip $ if the string has one
            strThisValue = [self clearDollarSymbol:strThisValue];
        
            [_dictResults setObject:strThisValue forKey:strThisKey];
    
        }
    }

    
}

   

#pragma mark - Calculate Discount

- (float) getDiscount : (OAI_TextField*) textField {
    
    float discount = 0.0;
    
    if (textField.text.length > 0 || textField.text != nil) {
        
        //check to see if the number is already formatted correctly
        NSRange percentSymbolCheck = [textField.text rangeOfString:@"%"];
        
        //only strip it if it has the %
        if (percentSymbolCheck.location != NSNotFound) {
            
            float thisPercent = [[self cleanPercentageSymbol:textField.text] floatValue];
            discount = thisPercent/100;
        
        } else {
            
            discount = [textField.text floatValue];
            
        }
        
    } else {
        
        //set  discount to 5%
        discount = 0.05;
        
    }
    
    return discount;
    

}

- (float) calculateDiscounts : (float) discount : (float) appliedTo {
    return appliedTo - (appliedTo*discount);
}

#pragma mark - Calculate Estimated Operating Cost

- (float) calculateEstimatedOperationalCost : (float) customPrice : (float) unitsPerCase : (float) unitsRecommendedForOperation {
    
    return (customPrice/unitsPerCase)*unitsRecommendedForOperation;
    
}

#pragma mark - Calculate Cost Per Cycle

- (float) calculateCostPerCycle : (float) estimatedOperatingCost : (float) estimatedNumberOfCycles {
    
    return estimatedOperatingCost/estimatedNumberOfCycles;
}

#pragma mark - Calculate Cost Per Scope

- (float) calculateCostPerScope : (float) myScopesPerBasin : (float) costPerCycle {

    return costPerCycle/myScopesPerBasin;
}

#pragma mark - Calculate Filters 

- (NSArray*) calculateFiltersCost : (float) myFilterDiscount : (float) myOERCount : (float) myCyclesPerYear : (float) myScopesPerBasin {
    
    //formula - list price  * number needed per year = total list price
    //tlp * discount = discounted price
    
    //numbers are provided by assumptions
    
    float MAJ822_TLP = 31.00 * 24;
    float MAJ823_TLP = 149.00 *  12;
    float MAJ824_TLP = 360.00 *  2;
    float MF01_00114PL_TLP = 15.00 * 2;
    float MF01_0015PL_TLP = 139.00 * 2;
    
    /*float MAJ822_CP = MAJ822_TLP - (MAJ822_TLP * myFilterDiscount);
    float MAJ823_CP = MAJ823_TLP - (MAJ823_TLP * myFilterDiscount);
    float MAJ824_CP = MAJ824_TLP - (MAJ824_TLP * myFilterDiscount);
    float MF01_00114PL_CP = MF01_0015PL_TLP - (MF01_00114PL_TLP * myFilterDiscount);
    float MF01_0015PL_CP = MF01_0015PL_TLP - (MF01_0015PL_TLP * myFilterDiscount);*/
    
    //total list price for all filters
    float filters_TLP = MAJ822_TLP + MAJ823_TLP + MAJ824_TLP + MF01_00114PL_TLP + MF01_0015PL_TLP;
    float filters_CP = (filters_TLP-(filters_TLP*myFilterDiscount)*myOERCount);
    float filters_CPC = filters_CP/myCyclesPerYear;
    float filters_CPS = filters_CPC/myScopesPerBasin;
    
    NSArray* arrMyFiltersCost = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%.02f", filters_CP], [NSString stringWithFormat:@"%.02f", filters_CPS], [NSString stringWithFormat:@"%f", filters_TLP], nil];
    
    return arrMyFiltersCost;
    
}

-(NSArray*) calculateServiceCost : (float) myServiceDiscount : (float) myCyclesPerYear : (float) myScopesPerBasin {
    
    float service_ELP = 3995.00; //froma assumptions
    float service_CP = service_ELP-(service_ELP*myServiceDiscount);
    
    float service_CPC = service_CP/myCyclesPerYear;
    
    float service_CPS = service_CPC/myScopesPerBasin;
    
    NSArray* arrServiceCost = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%f", service_CP], [NSString stringWithFormat:@"%f", service_CPS], nil];
    
    return arrServiceCost;
    
}

- (NSString*) cleanPercentageSymbol : (NSString*) stringToClean {
    
    //check to see if the number is already formatted correctly
    NSRange percentSymbolCheck = [stringToClean rangeOfString:@"%"];
    //only strip it if it has the $
    if (percentSymbolCheck.location != NSNotFound) {

        NSString* cleanedString = [stringToClean substringWithRange:NSMakeRange(0, stringToClean.length-1)];
        return cleanedString;
    
    } else {
        
        return stringToClean;
    
    }

    
}

- (NSString*) clearDollarSymbol : (NSString*) stringToClean {
    
    //check to see if the number is already formatted correctly
    NSRange dollarSignCheck = [stringToClean rangeOfString:@"$"];
    //only strip it if it has the $
    if (dollarSignCheck.location != NSNotFound) {
        
        NSString* cleanedString = [stringToClean substringWithRange:NSMakeRange(1, stringToClean.length-1)];
        
        
        return cleanedString;
        
    } else {
        
        return stringToClean;
        
    }
    
    return 0;

    
}

- (NSString*) convertToCurrencyString : (NSDecimalNumber*) numberToConvert {
    
    //convert to string
    NSString* currencyString = [NSNumberFormatter localizedStringFromNumber:numberToConvert numberStyle:NSNumberFormatterCurrencyStyle];
    
    return currencyString;
}





@end
