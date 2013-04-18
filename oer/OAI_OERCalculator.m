//
//  OAI_OERCalculator.m
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_OERCalculator.h"

@implementation OAI_OERCalculator

+(OAI_OERCalculator *)sharedCalculator {
    
    static OAI_OERCalculator* sharedCalculator;
    
    @synchronized(self) {
        
        if (!sharedCalculator)
            
            sharedCalculator = [[OAI_OERCalculator alloc] init];
        
        return sharedCalculator;
        
    }
    
}


/*
//this is user input data
float proceduresPerYear = 2000.0;
float scopesPerBasin = 1.75;
float discount = .05;
float cyclesPerYear = proceduresPerYear*scopesPerBasin;

//add to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", discount] forKey:@"Discount"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", proceduresPerYear] forKey:@"Procedures Per Year"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", scopesPerBasin] forKey:@"Scopes Per Basin"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", cyclesPerYear] forKey:@"Cycles Per Year"];


float ALDAHOL_base = 115.00;
float ALDAHOL_contractPrice = ALDAHOL_base - (ALDAHOL_base * discount);
float ALDAHOL_unitsPerCase = 4;
NSString* ALDAHOL_unitContent = @"1 Gallon Container";
int ALDAHOL_unitsRequired = 5;
float ALDAHOL_OperCost = (ALDAHOL_contractPrice/ALDAHOL_unitsPerCase)*ALDAHOL_unitsRequired;
float ALDAHOL_estimatedUsedPerCylce = 17.0;
float ALDAHOL_costPerCycle = ALDAHOL_OperCost/ALDAHOL_estimatedUsedPerCylce;
float ALDAHOL_costPerScope = ALDAHOL_costPerCycle/scopesPerBasin;

//add ALDAHOL to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_base] forKey:@"ALDAHOL Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_contractPrice] forKey:@"ALDAHOL Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_unitsPerCase] forKey:@"ALDAHOL Units Per Case"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", ALDAHOL_unitContent] forKey:@"ALDAHOL Unit Content"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%i", ALDAHOL_unitsRequired] forKey:@"ALDAHOL Units Required"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_OperCost] forKey:@"ALDAHOL Operating Cost"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_estimatedUsedPerCylce] forKey:@"ALDAHOL Estimated User Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_costPerCycle] forKey:@"ALDAHOL Cost Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ALDAHOL_costPerScope] forKey:@"ALDAHOL Cost Per Scope"];


float TestStrips_base = 105.00;
float TestStrips_contractPrice = TestStrips_base - (TestStrips_base * discount);
float TestStrips_unitsPerCase = 120;
NSString* TestStrips_unitContent = @"Each";
int TestStrips_unitsRequired = 1;
float TestStrips_OperCost = (TestStrips_contractPrice/TestStrips_unitsPerCase)*TestStrips_unitsRequired;
float TestStrips_estimatedUsedPerCylce = 1.0;
float TestStrips_costPerCycle = TestStrips_OperCost/TestStrips_estimatedUsedPerCylce;
float TestStrips_costPerScope = TestStrips_costPerCycle/scopesPerBasin;

//add ALDAHOL to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_base] forKey:@"Test Strips Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_contractPrice] forKey:@"Test Strips Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_unitsPerCase] forKey:@"Test Strips Unit Per Case"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", TestStrips_unitContent] forKey:@"Test Strips Unit Content"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%i", TestStrips_unitsRequired] forKey:@"Test Strips Units Required"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_OperCost] forKey:@"Test Strips Operating Cost"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_estimatedUsedPerCylce] forKey:@"Test Strips Estimated User Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_costPerCycle] forKey:@"Test Strips Cost Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", TestStrips_costPerScope] forKey:@"Test Strips Cost Per Scope"];

float AcecideTestStrips_base = 90.00;
float AcecideTestStrips_contractPrice = AcecideTestStrips_base - (AcecideTestStrips_base * discount);
float AcecideTestStrips_unitsPerCase = 100;
NSString* AcecideTestStrips_UnitContent = @"Each";
int AcecideTestStrips_unitsRequired = 1;
float AcecideTestStrips_OperCost = (AcecideTestStrips_contractPrice/AcecideTestStrips_unitsPerCase)*AcecideTestStrips_unitsRequired;
float AcecideTestStrips_estimatedUsedPerCylce = 1.0;
float AcecideTestStrips_costPerCycle = AcecideTestStrips_OperCost/AcecideTestStrips_estimatedUsedPerCylce;
float AcecideTestStrips_costPerScope = AcecideTestStrips_costPerCycle/scopesPerBasin;

//add Acecide Test Strips to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_base] forKey:@"Acecide Strips Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_contractPrice] forKey:@"Acecide Strips Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_unitsPerCase] forKey:@"Acecide Strips Unit Per Case"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", AcecideTestStrips_UnitContent] forKey:@"Acecide Strips Unit Content"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%i", AcecideTestStrips_unitsRequired] forKey:@"Acecide Strips Units Required"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_OperCost] forKey:@"Acecide Strips Operating Cost"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_estimatedUsedPerCylce] forKey:@"Acecide Strips Estimated User Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_costPerCycle] forKey:@"Acecide Strips Cost Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideTestStrips_costPerScope] forKey:@"Acecide Strips Cost Per Scope"];

float AcecideC_base = 990.00;
float AcecideC_contractPrice = AcecideC_base - (AcecideC_base * discount);
float AcecideC_unitsPerCase = 6;
NSString* AcecideC_UnitContent = @"1 Set";
int AcecideC_unitsRequired = 1;
float AcecideC_OperCost = (AcecideC_contractPrice/AcecideC_unitsPerCase)*AcecideC_unitsRequired;
float AcecideC_estimatedUsedPerCylce = 18.0;
float AcecideC_costPerCycle = AcecideC_OperCost/AcecideC_estimatedUsedPerCylce;
float AcecideC_costPerScope = AcecideC_costPerCycle/scopesPerBasin;

//add AcecideC to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_base] forKey:@"AcecideC Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_contractPrice] forKey:@"AcecideC Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_unitsPerCase] forKey:@"AcecideC Unit Per Case"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", AcecideC_UnitContent] forKey:@"AcecideC Unit Content"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%i", AcecideC_unitsRequired] forKey:@"AcecideC Units Required"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_OperCost] forKey:@"AcecideC Operating Cost"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_estimatedUsedPerCylce] forKey:@"AcecideC Estimated User Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_costPerCycle] forKey:@"AcecideC Cost Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AcecideC_costPerScope] forKey:@"AcecideC Cost Per Scope"];

float EndoQuick_base = 100.00;
float EndoQuick_contractPrice = EndoQuick_base - (EndoQuick_base * discount);
float EndoQuick_unitsPerCase = 3;
NSString* EndoQuick_UnitContent = @"2 Liter Container";
int EndoQuick_unitsRequired = 1;
float EndoQuick_OperCost = (EndoQuick_contractPrice/EndoQuick_unitsPerCase)*EndoQuick_unitsRequired;
float EndoQuick_estimatedUsedPerCylce = 30.0;
float EndoQuick_costPerCycle = EndoQuick_OperCost/EndoQuick_estimatedUsedPerCylce;
float EndoQuick_costPerScope = EndoQuick_costPerCycle/scopesPerBasin;

//add EndoQuick to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_base] forKey:@"EndoQuick Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_contractPrice] forKey:@"EndoQuick Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_unitsPerCase] forKey:@"EndoQuick Unit Per Case"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", EndoQuick_UnitContent] forKey:@"EndoQuick Unit Content"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%i", EndoQuick_unitsRequired] forKey:@"EndoQuick Units Required"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_OperCost] forKey:@"EndoQuick Operating Cost"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_estimatedUsedPerCylce] forKey:@"EndoQuick Estimated User Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_costPerCycle] forKey:@"EndoQuick Cost Per Cycle"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", EndoQuick_costPerScope] forKey:@"EndoQuick Cost Per Scope"];



NSString* VaporFilter_ItemNum = @"MAJ-822";
float VaporFilter_ListPrice = 31.00;
float VaporFilter_contractPrice = VaporFilter_ListPrice-(VaporFilter_ListPrice*discount);
float VaporFilter_annualNum = 24.0;
float VaporFilter_totalList = VaporFilter_ListPrice * VaporFilter_annualNum;
float VaportFilter_totalDiscount = VaporFilter_contractPrice * VaporFilter_annualNum;

//add EndoQuick to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", VaporFilter_ItemNum] forKey:@"Vapor Filter Item Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", VaporFilter_ListPrice] forKey:@"Vapor Filter Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", VaporFilter_contractPrice] forKey:@"Vapor Filter Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", VaporFilter_annualNum] forKey:@"Vapor Filter Annual Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", VaporFilter_totalList] forKey:@"Vapor Filter Total List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", VaportFilter_totalDiscount] forKey:@"Vapor Filter Total Discount Price"];

NSString* AirFilter_ItemNum = @"MAJ-823";
float AirFilter_ListPrice = 149.00;
float AirFilter_contractPrice = AirFilter_ListPrice-(AirFilter_ListPrice*discount);
float AirFilter_annualNum = 12.0;
float AirFilter_totalList = AirFilter_ListPrice * AirFilter_annualNum;
float AirFilter_totalDiscount = AirFilter_contractPrice * AirFilter_annualNum;

//add AirFilter to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", AirFilter_ItemNum] forKey:@"Air Filter Item Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_ListPrice] forKey:@"Air Filter Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_contractPrice] forKey:@"Vapor Filter Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_annualNum] forKey:@"Air Filter Annual Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalList] forKey:@"Air Filter Total List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalDiscount] forKey:@"Air Filter Total Discount Price"];

NSString* InternalWaterFilter_ItemNum = @"MAJ-824";
float InternalWaterFilter_ListPrice = 360.00;
float InternalWaterFilter_contractPrice = InternalWaterFilter_ListPrice-(InternalWaterFilter_ListPrice*discount);
float InternalWaterFilter_annualNum = 2.0;
float InternalWaterFilter_totalList = InternalWaterFilter_ListPrice * InternalWaterFilter_annualNum;
float InternalWaterFilter_totalDiscount = InternalWaterFilter_contractPrice * InternalWaterFilter_annualNum;

//add AirFilter to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", AirFilter_ItemNum] forKey:@"Air Filter Item Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_ListPrice] forKey:@"Air Filter Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_contractPrice] forKey:@"Vapor Filter Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_annualNum] forKey:@"Air Filter Annual Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalList] forKey:@"Air Filter Total List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalDiscount] forKey:@"Air Filter Total Discount Price"];

NSString* ExternalWaterFilter_ItemNum = @"MF01-0014PL";
float ExternalWaterFilter_ListPrice = 15.00;
float ExternalWaterFilter_contractPrice = ExternalWaterFilter_ListPrice-(ExternalWaterFilter_ListPrice*discount);
float ExternalWaterFilter_annualNum = 2.0;
float ExternalWaterFilter_totalList = ExternalWaterFilter_ListPrice * ExternalWaterFilter_annualNum;
float ExternalWaterFilter_totalDiscount = ExternalWaterFilter_contractPrice * ExternalWaterFilter_annualNum;

//add AirFilter to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", AirFilter_ItemNum] forKey:@"Air Filter Item Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_ListPrice] forKey:@"Air Filter Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_contractPrice] forKey:@"Air Filter Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_annualNum] forKey:@"Air Filter Annual Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalList] forKey:@"Air Filter Total List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", AirFilter_totalDiscount] forKey:@"Air Filter Total Discount Price"];

NSString* ExternalMicronFilter_ItemNum = @"MF01-0015PL";
float ExternalMicronFilter_ListPrice = 139.00;
float ExternalMicronFilter_contractPrice = ExternalMicronFilter_ListPrice-(ExternalMicronFilter_ListPrice*discount);
float ExternalMicronFilter_annualNum = 2.0;
float ExternalMicronFilter_totalList = ExternalMicronFilter_ListPrice * ExternalMicronFilter_annualNum;
float ExternalMicronFilter_totalDiscount = ExternalMicronFilter_contractPrice * ExternalMicronFilter_annualNum;

//add External to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%@", ExternalMicronFilter_ItemNum] forKey:@"ExternalMicron Filter Item Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ExternalMicronFilter_ListPrice] forKey:@"ExternalMicron Filter Base Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ExternalMicronFilter_contractPrice] forKey:@"ExternalMicron Filter Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ExternalMicronFilter_annualNum] forKey:@"ExternalMicron Filter Annual Number"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ExternalMicronFilter_totalList] forKey:@"ExternalMicron Filter Total List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", ExternalMicronFilter_totalDiscount] forKey:@"ExternalMicron Filter Total Discount Price"];

float filterListTotal = VaporFilter_totalList + AirFilter_totalList + InternalWaterFilter_totalList + ExternalWaterFilter_totalList + ExternalMicronFilter_totalList;

//add External to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", filterListTotal] forKey:@"Filter List Total"];

float filterDiscountTotal = VaportFilter_totalDiscount + AirFilter_totalDiscount + InternalWaterFilter_totalDiscount + ExternalWaterFilter_totalDiscount + ExternalMicronFilter_totalDiscount;

//add External to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", filterDiscountTotal] forKey:@"Filter Discount Total"];


float service_ListPrice = 3995.00;
float service_contractPrice = service_ListPrice-(service_ListPrice*discount);
float service_annualNum = service_contractPrice/cyclesPerYear;
float service_costPrScope = service_annualNum/scopesPerBasin;

//add External to the dict
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", service_ListPrice] forKey:@"Service List Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", service_contractPrice] forKey:@"Service Contract Price"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", service_annualNum] forKey:@"Service Annual Num"];
[dictAssumptions setObject:[NSString stringWithFormat:@"%f", service_costPrScope] forKey:@"Service Cost Per Scope"];





}*/


@end
