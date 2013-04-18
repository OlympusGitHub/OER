//
//  OAI_OERCalculator.h
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAI_OERCalculator : NSObject {
    
}

@property (nonatomic, assign) float proceduresPerYear;
@property (nonatomic, assign) float scopesPerBasin;
@property (nonatomic, assign) float discount;
@property (nonatomic, assign) float cyclesPerYear;
@property (nonatomic, assign) float ALDAHOL_base;
@property (nonatomic, assign) float ALDAHOL_contractPrice;
@property (nonatomic, assign) float ALDAHOL_unitsPerCase;
@property (nonatomic, retain) NSString* ALDAHOL_unitContent;
@property (nonatomic, assign) int ALDAHOL_unitsRequired;
@property (nonatomic, assign) float ALDAHOL_OperCost;
@property (nonatomic, assign) float ALDAHOL_estimatedUsedPerCylce;
@property (nonatomic, assign) float ALDAHOL_costPerCycle;
@property (nonatomic, assign) float ALDAHOL_costPerScope;
@property (nonatomic, assign) float TestStrips_base;
@property (nonatomic, assign) float TestStrips_contractPrice;
@property (nonatomic, assign) float TestStrips_unitsPerCase;
@property (nonatomic, retain) NSString* TestStrips_unitContent;
@property (nonatomic, assign) int TestStrips_unitsRequired;
@property (nonatomic, assign) float TestStrips_OperCost;
@property (nonatomic, assign) float TestStrips_estimatedUsedPerCylce;
@property (nonatomic, assign) float TestStrips_costPerCycle;
@property (nonatomic, assign) float TestStrips_costPerScope;
@property (nonatomic, assign) float AcecideTestStrips_base;
@property (nonatomic, assign) float AcecideTestStrips_contractPrice;
@property (nonatomic, assign) float AcecideTestStrips_unitsPerCase;
@property (nonatomic, retain) NSString* AcecideTestStrips_UnitContent;
@property (nonatomic, assign) int AcecideTestStrips_unitsRequired;
@property (nonatomic, assign) float AcecideTestStrips_OperCost;
@property (nonatomic, assign) float AcecideTestStrips_estimatedUsedPerCylce;
@property (nonatomic, assign) float AcecideTestStrips_costPerCycle;
@property (nonatomic, assign) float AcecideTestStrips_costPerScope;
@property (nonatomic, assign) float AcecideC_base;
@property (nonatomic, assign) float AcecideC_contractPrice;
@property (nonatomic, assign) float AcecideC_unitsPerCase;
@property (nonatomic, retain) NSString* AcecideC_UnitContent;
@property (nonatomic, assign) int AcecideC_unitsRequired;
@property (nonatomic, assign) float AcecideC_OperCost;
@property (nonatomic, assign) float AcecideC_estimatedUsedPerCylce;
@property (nonatomic, assign) float AcecideC_costPerCycle;
@property (nonatomic, assign) float AcecideC_costPerScope;
@property (nonatomic, assign) float EndoQuick_base;
@property (nonatomic, assign) float EndoQuick_contractPrice;
@property (nonatomic, assign) float EndoQuick_unitsPerCase;
@property (nonatomic, retain) NSString* EndoQuick_UnitContent;
@property (nonatomic, assign) int EndoQuick_unitsRequired;
@property (nonatomic, assign) float EndoQuick_OperCost;
@property (nonatomic, assign) float EndoQuick_estimatedUsedPerCylce;
@property (nonatomic, assign) float EndoQuick_costPerCycle;
@property (nonatomic, assign) float EndoQuick_costPerScope;
@property (nonatomic, retain) NSString* VaporFilter_ItemNum;
@property (nonatomic, assign) float VaporFilter_ListPrice;
@property (nonatomic, assign) float VaporFilter_contractPrice;
@property (nonatomic, assign) float VaporFilter_annualNum;
@property (nonatomic, assign) float VaporFilter_totalList;
@property (nonatomic, assign) float VaportFilter_totalDiscount;
@property (nonatomic, retain) NSString* AirFilter_ItemNum;
@property (nonatomic, assign) float AirFilter_ListPrice;
@property (nonatomic, assign) float AirFilter_contractPrice;
@property (nonatomic, assign) float AirFilter_annualNum;
@property (nonatomic, assign) float AirFilter_totalList;
@property (nonatomic, assign) float AirFilter_totalDiscount;
@property (nonatomic, retain) NSString* InternalWaterFilter_ItemNum;
@property (nonatomic, assign) float InternalWaterFilter_ListPrice;
@property (nonatomic, assign) float InternalWaterFilter_contractPrice;
@property (nonatomic, assign) float InternalWaterFilter_annualNum;
@property (nonatomic, assign) float InternalWaterFilter_totalList;
@property (nonatomic, assign) float InternalWaterFilter_totalDiscount;
@property (nonatomic, retain) NSString* ExternalWaterFilter_ItemNum;
@property (nonatomic, assign) float ExternalWaterFilter_ListPrice;
@property (nonatomic, assign) float ExternalWaterFilter_contractPrice;
@property (nonatomic, assign) float ExternalWaterFilter_annualNum;
@property (nonatomic, assign) float ExternalWaterFilter_totalList;
@property (nonatomic, assign) float ExternalWaterFilter_totalDiscount;
@property (nonatomic, retain) NSString* ExternalMicronFilter_ItemNum;
@property (nonatomic, assign) float ExternalMicronFilter_ListPrice;
@property (nonatomic, assign) float ExternalMicronFilter_contractPrice;
@property (nonatomic, assign) float ExternalMicronFilter_annualNum;
@property (nonatomic, assign) float ExternalMicronFilter_totalList;
@property (nonatomic, assign) float ExternalMicronFilter_totalDiscount;
@property (nonatomic, assign) float filterListTotal;
@property (nonatomic, assign) float filterDiscountTotal;





+(OAI_OERCalculator* )sharedCalculator;

@end
