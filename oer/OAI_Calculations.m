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
    
    BOOL doChemicals = NO;
    BOOL doOthers = NO;
    
    if([strCalculateWhat isEqualToString:@"Chemicals"]) {
        doChemicals = YES;
    } else if ([strCalculateWhat isEqualToString:@"Others"]) {
        doOthers = YES;
    } else {
        doChemicals = YES;
        doOthers = YES;
    }
    
    _dictResults = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* dictFieldsToCalculate = [[NSMutableDictionary alloc] init];
        
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
    [_dictResults setObject:[NSString stringWithFormat:@"%i", intCyclesPerYear] forKey:@"Annual Cycle Count"];
    
    //these are the assumptions provided in the excel sheet
    
    //list prices
    float ALDAHOL_LP = 115.00;
    float Comply_Strips_LP = 105.00;
    float Acecide_Test_Strips_LP = 90.00;
    float AcecideC_LP = 990.00;
    float EndoQuick_LP = 100.0;
    
    //filters array
    NSArray* arrFiltersCost = [[NSArray alloc] init];
    
    //filters
    
    /* 
        Legend: 
            CP = Custom Price (Purchase Price) = List Price * Discount
            EOC = Estimated Operating Cost = (customPrice/unitsPerCase)*unitsRecommendedForOperation
            UPC = Units Per Case - from assumptions
            URFO = Units Required For Operation - from assumptions
            ENC = Estimated Number of Cycles (Maximum) - from assumptions
            CPS = Cost Per Scope = Cost Per Cycle/Scopes Per Basin
            CPC = Cost Per Cycle = EOC/ENC
    */
        
    
    for(NSString* strThisKey in _dictTextFields) {
        
        //check to see if we are calculating chemicalss
        if (doChemicals) {
            
            //set the chemistry values
            if ([strThisKey rangeOfString:@"Chemicals"].location != NSNotFound) {
            
                //set the ALDAHOL values
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        //values needed to be displayed
                        float ALDAHOLChemicalDiscount = 0.0;
                        float ALDAHOLChemicalCP = 0.0;
                        float ALDAHOLChemicalEOC = 0.0;
                        float ALDAHOLChemicalUPC = 4;
                        float ALDAHOLChemicalURFO = 5;
                        float ALDAHOLChemicalENC = 17;
                        float ALDAHOLChemicalCPC = 0.0;
                        float ALDAHOLChemicalCPS = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        ALDAHOLChemicalDiscount = [self getDiscount:txtThisDiscount];
                        
                        //ALDAHOL Chemical Custom Price
                        ALDAHOLChemicalCP = [self calculateDiscounts:ALDAHOLChemicalDiscount :ALDAHOL_LP];
                        //ALDAHOL Chemical EOC - (CP/UPC)*URFO
                        ALDAHOLChemicalEOC = [self calculateEstimatedOperationalCost:ALDAHOLChemicalCP :ALDAHOLChemicalUPC :ALDAHOLChemicalURFO];
                        //ALDAHOL chemical cost per cylce - UPC/ENC
                        ALDAHOLChemicalCPC = [self calculateCostPerCycle:ALDAHOLChemicalEOC:ALDAHOLChemicalENC];
                        //ALDAHOL chemical cost per scope
                        ALDAHOLChemicalCPS = [self calculateCostPerScope:scopesPerBasin :ALDAHOLChemicalCPC];
                        
                        //store results for ALDAHOL Chemical
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalDiscount] forKey:@"Chemicals_Discount_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalUPC] forKey:@"Chemicals_Units Per Package_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalCP] forKey:@"Chemicals_Purchase Price (per case)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalENC] forKey:@"Chemicals_Maximum Use Life (# cycles per basin)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalEOC] forKey:@"ALDAHOL Chemical Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalCPC] forKey:@"ALDAHOL Chemical Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalCPS] forKey:@"Chemicals_Chemical Cost Per Scope_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLChemicalURFO] forKey:@"Chemicals_Units Required For Operation (per basin)_ALDAHOL"];
                        
                    }//endALDAHOL Chemical
                    
                } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
                    
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        float AcecideCChemicalDiscount = 0.0;
                        float AcecideCChemicalCP = 0.0;
                        float AcecideCChemicalEOC = 0.0;
                        float AcecideCChemicalUPC = 6;
                        float AcecideCChemicalURFO = 1;
                        float AcecideCChemicalENC = 18;
                        float AcecideCChemicalCPC = 0.0;
                        float AcecideCChemicalCPS = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        AcecideCChemicalDiscount = [self getDiscount:txtThisDiscount];
                        
                        //AcecideC Chemical Custom Price
                        AcecideCChemicalCP = [self calculateDiscounts:AcecideCChemicalDiscount :AcecideC_LP];
                        //AcecideC Chemical EOC - (CP/UPC)*URFO
                        AcecideCChemicalEOC = [self calculateEstimatedOperationalCost:AcecideCChemicalCP :AcecideCChemicalUPC :AcecideCChemicalURFO];
                        //AcecideC chemical cost per cylce - UPC/ENC
                        AcecideCChemicalCPC = [self calculateCostPerCycle:AcecideCChemicalEOC:AcecideCChemicalENC];
                        //AcecideC chemical cost per scope
                        AcecideCChemicalCPS = [self calculateCostPerScope:scopesPerBasin :AcecideCChemicalCPC];
                        
                        //store results for AcecideC Chemical
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalDiscount] forKey:@"Chemicals_Discount_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalUPC] forKey:@"Chemicals_Units Per Package_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalCP] forKey:@"Chemicals_Purchase Price (per case)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalENC] forKey:@"Chemicals_Maximum Use Life (# cycles per basin)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalEOC] forKey:@"AcecideC Chemical Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalCPC] forKey:@"AcecideC Chemical Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalCPS] forKey:@"Chemicals_Chemical Cost Per Scope_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCChemicalURFO] forKey:@"Chemicals_Units Required For Operation (per basin)_AcecideC"];
                        
                    }//end Acecidic Chemical
                
                } else if ([strThisKey rangeOfString:@"Competition"].location !=NSNotFound) {
                    
                    //store results for AcecideC Chemical
                    [_dictResults setObject:@"" forKey:@"Chemicals_Discount_Competition"];
                    
                    [_dictResults setObject:@"" forKey:@"Chemicals_Units Per Package_Competition"];
                    
                    [_dictResults setObject:@"" forKey:@"Chemicals_Purchase Price (per case)_Competition"];
                    
                    [_dictResults setObject:@"" forKey:@"Chemicals_Maximum Use Life (# cycles per basin)_Competition"];
                    
                    [_dictResults setObject:@"" forKey:@"Competition Chemical Estimated Operational Cost"];
                    
                    [_dictResults setObject:@"" forKey:@"Competition Chemical Cost Per Cycle"];
                    
                    [_dictResults setObject:@"" forKey:@"Chemicals_Chemical Cost Per Scope_Competition"];
                    
                    [_dictResults setObject:@"" forKey:@"Chemicals_Units Required For Operation (per basin)_Competition"];
                }
            }
            
        }//end do chems check
        
        
        //check to see if we are calculating the others
        if (doOthers) {
            
            if ([strThisKey rangeOfString:@"Detergent"].location !=NSNotFound) {
                
                
                
                //set the ALDAHOL values
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        //values needed to be displayed
                        float ALDAHOLDetergentDiscount = 0.0;
                        float ALDAHOLDetergentCP = 0.0;
                        float ALDAHOLDetergentEOC = 0.0;
                        float ALDAHOLDetergentUPC = 3;
                        float ALDAHOLDetergentURFO = 1;
                        float ALDAHOLDetergentENC = 30;
                        float ALDAHOLDetergentCPC = 0.0;
                        float ALDAHOLDetergentCPS = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        ALDAHOLDetergentDiscount = [self getDiscount:txtThisDiscount];
                        
                        //ALDAHOL Chemical Custom Price
                        ALDAHOLDetergentCP = [self calculateDiscounts:ALDAHOLDetergentDiscount :EndoQuick_LP];
                        //ALDAHOL Chemical EOC - (CP/UPC)*URFO
                        ALDAHOLDetergentEOC = [self calculateEstimatedOperationalCost:ALDAHOLDetergentCP :ALDAHOLDetergentUPC :ALDAHOLDetergentURFO];
                        //ALDAHOL chemical cost per cylce - UPC/ENC
                        ALDAHOLDetergentCPC = [self calculateCostPerCycle:ALDAHOLDetergentEOC:ALDAHOLDetergentENC];
                        //ALDAHOL chemical cost per scope
                        ALDAHOLDetergentCPS = [self calculateCostPerScope:scopesPerBasin :ALDAHOLDetergentCPC];
                        
                        //store results for ALDAHOL Chemical
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentDiscount] forKey:@"Detergents_Discount_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentUPC] forKey:@"Detergents_Units Per Package_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCP] forKey:@"Detergents_Purchase Price (per case)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentENC] forKey:@"Detergents_Maximum Use Life (# cycles per basin)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentEOC] forKey:@"ALDAHOL Detergents Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCPC] forKey:@"ALDAHOL Detergents Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCPS] forKey:@"Detergents_Detergent Cost Per Scope_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentURFO] forKey:@"Detergents_Units Required For Operation (per basin)_ALDAHOL"];
                        
                        //the numbers are identical AcecideC for the detergent
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentDiscount] forKey:@"Detergents_Discount_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentUPC] forKey:@"Detergents_Units Per Package_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCP] forKey:@"Detergents_Purchase Price (per case)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentENC] forKey:@"Detergents_Maximum Use Life (# cycles per basin)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentEOC] forKey:@"AcecideC Detergents Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCPC] forKey:@"AcecideC Detergents Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentCPS] forKey:@"Detergents_Detergent Cost Per Scope_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLDetergentURFO] forKey:@"Detergents_Units Required For Operation (per basin)_AcecideC"];
                        
                        //set the detergent cost for competition
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Discount_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Units Per Package_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Purchase Price (per case)_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Maximum Use Life (# cycles per basin)_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Competition Detergents Estimated Operational Cost"];
                        
                        [_dictResults setObject:@"" forKey:@"Competition Detergents Cost Per Cycle"];
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Detergent Cost Per Scope_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Detergents_Units Required For Operation (per basin)_Competition"];
                        
                    }//end ALDAHOL Detergent
                
                }
            
            } else if ([strThisKey rangeOfString:@"Test Strips"].location !=NSNotFound) {
                
                //set the ALDAHOL values
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        //values needed to be displayed
                        float ALDAHOLTestStripsDiscount = 0.0;
                        float ALDAHOLTestStripCP = 0.0;
                        float ALDAHOLTestStripEOC = 0.0;
                        float ALDAHOLTestStripUPC = 120;
                        float ALDAHOLTestStripURFO = 1;
                        float ALDAHOLTestStripENC = 1;
                        float ALDAHOLTestStripCPC = 0.0;
                        float ALDAHOLTestStripCPS = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        ALDAHOLTestStripsDiscount = [self getDiscount:txtThisDiscount];
                        
                        //ALDAHOL Chemical Custom Price
                        ALDAHOLTestStripCP = [self calculateDiscounts:ALDAHOLTestStripsDiscount :Comply_Strips_LP];
                        //ALDAHOL Chemical EOC - (CP/UPC)*URFO
                        ALDAHOLTestStripEOC = [self calculateEstimatedOperationalCost:ALDAHOLTestStripCP :ALDAHOLTestStripUPC :ALDAHOLTestStripURFO];
                        //ALDAHOL chemical cost per cylce - UPC/ENC
                        ALDAHOLTestStripCPC = [self calculateCostPerCycle:ALDAHOLTestStripEOC:ALDAHOLTestStripENC];
                        //ALDAHOL chemical cost per scope
                        ALDAHOLTestStripCPS = [self calculateCostPerScope:scopesPerBasin :ALDAHOLTestStripCPC];
                        
                        //store results for ALDAHOL Chemical
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripsDiscount] forKey:@"Test Strips_Discount_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripUPC] forKey:@"Test Strips_Units Per Package_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripCP] forKey:@"Test Strips_Purchase Price (per case)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripENC] forKey:@"Test Strips_Maximum Use Life (# cycles per basin)_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripEOC] forKey:@"ALDAHOL Test Strips Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripCPC] forKey:@"ALDAHOL Test Strips Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripCPS] forKey:@"Test Strips_Test Strip Cost Per Scope_ALDAHOL"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLTestStripURFO] forKey:@"Test Strip_Units Required For Operation (per basin)_ALDAHOL"];
                    }
                    
                } else if ([strThisKey rangeOfString:@"Acecide"].location !=NSNotFound) {
                        
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        //values needed to be displayed
                        float AcecideCTestStripsDiscount = 0.0;
                        float AcecideCTestStripCP = 0.0;
                        float AcecideCTestStripEOC = 0.0;
                        float AcecideCTestStripUPC = 100;
                        float AcecideCTestStripURFO = 1;
                        float AcecideCTestStripENC = 1;
                        float AcecideCTestStripCPC = 0.0;
                        float AcecideCTestStripCPS = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        AcecideCTestStripsDiscount = [self getDiscount:txtThisDiscount];
                        
                        //ALDAHOL Chemical Custom Price
                        AcecideCTestStripCP = [self calculateDiscounts:AcecideCTestStripsDiscount :Acecide_Test_Strips_LP];
                        //ALDAHOL Chemical EOC - (CP/UPC)*URFO
                        AcecideCTestStripEOC = [self calculateEstimatedOperationalCost:AcecideCTestStripCP :AcecideCTestStripUPC :AcecideCTestStripURFO];
                        //ALDAHOL chemical cost per cylce - UPC/ENC
                        AcecideCTestStripCPC = [self calculateCostPerCycle:AcecideCTestStripEOC:AcecideCTestStripENC];
                        //ALDAHOL chemical cost per scope
                        AcecideCTestStripCPS = [self calculateCostPerScope:scopesPerBasin :AcecideCTestStripCPC];
                        
                        //store results for ALDAHOL Chemical
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripsDiscount] forKey:@"Test Strips_Discount_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripUPC] forKey:@"Test Strips_Units Per Package_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripCP] forKey:@"Test Strips_Purchase Price (per case)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripENC] forKey:@"Test Strips_Maximum Use Life (# cycles per basin)_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripEOC] forKey:@"AcecideC Test Strips Estimated Operational Cost"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripCPC] forKey:@"AcecideC Test Strips Cost Per Cycle"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripCPS] forKey:@"Test Strips_Test Strip Cost Per Scope_AcecideC"];
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", AcecideCTestStripURFO] forKey:@"Test Strip_Units Required For Operation (per basin)_AcecideC"];
                        
                        //set the competition here as well
                        //set the detergent cost for competition
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Discount_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Units Per Package_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Purchase Price (per case)_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Maximum Use Life (# cycles per basin)_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Competition Test Strips Estimated Operational Cost"];
                        
                        [_dictResults setObject:@"" forKey:@"Competition Test Strips Cost Per Cycle"];
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Test Strip Cost Per Scope_Competition"];
                        
                        [_dictResults setObject:@"" forKey:@"Test Strips_Units Required For Operation (per basin)_Competition"];
                            
                    }
                }
                
            } else if ([strThisKey rangeOfString:@"Filters"].location !=NSNotFound) {
                
                //set the ALDAHOL values
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    //get the discount
                    if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                        
                        float ALDAHOLFiltersDiscount = 0.0;
                        
                        OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                        ALDAHOLFiltersDiscount = [self getDiscount:txtThisDiscount];
                        
                        //get the filter cost
                        arrFiltersCost = [self calculateFiltersCost:ALDAHOLFiltersDiscount:OERCount:cyclesPerYear:scopesPerBasin];
                        
                        //pull the results
                        NSString* strFilterCP = [arrFiltersCost objectAtIndex:0];
                        NSString* strFilterCPS = [arrFiltersCost objectAtIndex:1];
                        
                        //ALDAHOL
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLFiltersDiscount] forKey:@"Filters_Discount_ALDAHOL"];
                        [_dictResults setObject:strFilterCP forKey:@"Filters_Annual Cost_ALDAHOL"];
                        [_dictResults setObject:strFilterCPS forKey:@"Filters_Filter Cost Per Scope_ALDAHOL"];
                        
                        //AcecideC
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLFiltersDiscount] forKey:@"Filters_Discount_AcecideC"];
                        [_dictResults setObject:strFilterCP forKey:@"Filters_Annual Cost_AcecideC"];
                        [_dictResults setObject:strFilterCPS forKey:@"Filters_Filter Cost Per Scope_AcecideC"];
                        
                        //Competition
                        
                        //changed 4/22 was .67
                        float CompetitionFilter_CPS = 0.0;
                        float CompetitionFilter_CP = CompetitionFilter_CPS * cyclesPerYear;
                        
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", CompetitionFilter_CP] forKey:@"Filters_Annual Cost_Competition"];
                        [_dictResults setObject:[NSString stringWithFormat:@"%.02f", CompetitionFilter_CPS] forKey:@"Filters_Filter Cost Per Scope_Competition"];
                        
                    }
                }
            }
        }//end doOthers check
            
        
        //non-discount calculations
        if ([strThisKey rangeOfString:@"Service"].location !=NSNotFound) {
            
            //set the ALDAHOL values
            if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                
                //get the discount
                if ([strThisKey rangeOfString:@"Discount"].location !=NSNotFound) {
                    
                    float ALDAHOLServiceDiscount = 0.0;
                    
                    OAI_TextField* txtThisDiscount = [_dictTextFields objectForKey:strThisKey];
                    ALDAHOLServiceDiscount = [self getDiscount:txtThisDiscount];
                    
                    NSArray* arrServiceCost = [self calculateServiceCost:ALDAHOLServiceDiscount:cyclesPerYear:scopesPerBasin];
                    
                    //pull the results
                    NSString* strServiceCP = [arrServiceCost objectAtIndex:0];
                    NSString* strServiceCPS = [arrServiceCost objectAtIndex:1];
                    
                    //ALDAHOL
                    [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLServiceDiscount] forKey:@"Service_Discount_ALDAHOL"];
                    [_dictResults setObject:strServiceCP forKey:@"Service_Annual Cost_ALDAHOL"];
                    [_dictResults setObject:strServiceCPS forKey:@"Service_Service Cost Per Scope_ALDAHOL"];
                    
                    //AcecideC
                    [_dictResults setObject:[NSString stringWithFormat:@"%.02f", ALDAHOLServiceDiscount] forKey:@"Service_Discount_AcecideC"];
                    [_dictResults setObject:strServiceCP forKey:@"Service_Annual Cost_AcecideC"];
                    [_dictResults setObject:strServiceCPS forKey:@"Service_Service Cost Per Scope_AcecideC"];
                    
                    //Competition
                    [_dictResults setObject:@""forKey:@"Service_Annual Cost_Competition"];
                    [_dictResults setObject:@"" forKey:@"Service_Filter Cost Per Scope_Competition"];
                                        
                }
            }
            
        } else if ([strThisKey rangeOfString:@"Labor"].location !=NSNotFound) {
            
            float laborCAS = 0.0;
            float laborCPS = (laborCAS/cyclesPerYear)/scopesPerBasin;
            
            //ALDAHOL Labor
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCAS] forKey:@"Labor_Additional Cost Above Service_ALDAHOL"];
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCPS] forKey:@"Labor_Labor Cost Per Scope_ALDAHOL"];
            
            //AcecideC Labor
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCAS] forKey:@"Labor_Additional Cost Above Service_AcecideC"];
            [_dictResults setObject:[NSString stringWithFormat:@"%.02f", laborCPS] forKey:@"Labor_Labor Cost Per Scope_AcecideC"];
            
            //Competition
            [_dictResults setObject:@"0.0" forKey:@"Labor_Labor Cost Per Scope_Competition"];
            
        } else if ([strThisKey rangeOfString:@"Operation"].location !=NSNotFound) {
            
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
        }
    }
    
    //return the data
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    [userData setObject:_dictResults forKey:@"Results"];
    [userData setObject:@"Show Results" forKey:@"Action"];
    
    /*This is the call back to the notification center, */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];

}

#pragma mark - Calculate Discount

- (float) getDiscount : (OAI_TextField*) textField {
    
    float discount = 0.0;
    
    if (textField.text.length > 0 || textField.text != nil) {
        
        //check to see if the number is already formatted correctly
        NSRange percentSymbolCheck = [textField.text rangeOfString:@"%"];
        
        //only strip it if it has the %
        if (percentSymbolCheck.location != NSNotFound) {
            
            float thisPercent = [self cleanPercentageSymbol:textField.text];
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

- (float) cleanPercentageSymbol : (NSString*) stringToClean {
    
    //check to see if the number is already formatted correctly
    NSRange percentSymbolCheck = [stringToClean rangeOfString:@"%"];
    //only strip it if it has the $
    if (percentSymbolCheck.location != NSNotFound) {

        NSString* cleanedString = [stringToClean substringWithRange:NSMakeRange(0, stringToClean.length-1)];
        return [cleanedString floatValue];
    
    } else {
        
        return [stringToClean floatValue];
    
    }

    
}

- (float) clearnDollarSymbol : (NSString*) stringToClean {
    
    //check to see if the number is already formatted correctly
    NSRange dollarSignCheck = [stringToClean rangeOfString:@"$"];
    //only strip it if it has the $
    if (dollarSignCheck.location != NSNotFound) {
        
        NSString* cleanedString = [stringToClean substringWithRange:NSMakeRange(1, stringToClean.length-1)];
        return [cleanedString floatValue];
        
    } else {
        
        return [stringToClean floatValue];
        
    }
    
    return 0;

    
}




@end
