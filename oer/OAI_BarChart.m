//
//  OAI_BarChart.m
//  OER
//
//  Created by Steve Suranie on 4/5/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_BarChart.h"

@implementation OAI_BarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        colorManager = [[OAI_ColorManager alloc] init];
        
        UIColor* clrOlympusYellow = [colorManager setColor:233.0 :178.0 :38.0];
        UIColor* clrOlympusBlue = [colorManager setColor:8.0 :16.0 :123.0];
        UIColor* clrDarkGrey = [colorManager setColor:51:51 :51];
        UIColor* clrLightGrey = [colorManager setColor:204.0 :204.0 :204.0];
        UIColor* clrBar2 = [colorManager setColor:91.0 :28.0 :143.0];
        UIColor* clrBar3 = [colorManager setColor:143.0 :69.0 :28.0];
        UIColor* clrBar4 = [colorManager setColor:28.0 :143.0 :50.0];
        
        arrColorSets = [[NSArray alloc] initWithObjects:
                            clrOlympusYellow,
                            clrOlympusBlue,
                            clrDarkGrey,
                            clrLightGrey,
                            clrBar2,
                            clrBar3,
                            clrBar4,
                        nil];
        
    }
    return self;
}

- (void) buildBarChart : (int) barCount : (NSArray* ) arrBarData : (NSString*) chartName : (BOOL) hasBorder : (int) barStyle : (NSArray*) arrBarLabels  {
    
    
    //add the chart label
    CGSize chartNameSize = [chartName sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
    
    UILabel* lblChartTitle = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 5.0, chartNameSize.width, chartNameSize.height)];
    lblChartTitle.text = chartName;
    lblChartTitle.textColor = [arrColorSets objectAtIndex:1];
    lblChartTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    lblChartTitle.backgroundColor = [UIColor clearColor];
    
    [self addSubview:lblChartTitle];
    
    
    float chartH = self.frame.size.height + (lblChartTitle.frame.origin.y + lblChartTitle.frame.size.height + 10.0);
    float maxLabelWidth = 0.0;
    float labelX = 40.0;
    float labelY = lblChartTitle.frame.origin.y + lblChartTitle.frame.size.height + 10.0;
    float barW = 0.0;
    float barH = 0.0;
    float barX = 0.0;
    float barY = lblChartTitle.frame.origin.y + lblChartTitle.frame.size.height + 10.0;
    
    if (barStyle == 0) {
        
        //set the height of the bar chart
        for(int i=0; i<arrBarData.count; i++) {
        
            if (([[arrBarData objectAtIndex:i] floatValue] + 10.0) > chartH) {
                chartH = [[arrBarData objectAtIndex:i] floatValue] * 10.0;
            }
        }
        
    } else {
        
        //set the height of the bar chart
        chartH = chartH + (30*arrBarData.count) + 10.0;
        
        for(int i=0; i<arrBarLabels.count; i++) {
            
            NSString* strThisLabel = [NSString stringWithFormat:@"%@ %@:",[arrBarLabels objectAtIndex:i], [arrBarData objectAtIndex:i]];
            CGSize thisLabelSize = [strThisLabel sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
            if (thisLabelSize.width > maxLabelWidth) {
                maxLabelWidth = thisLabelSize.width;
            }
        }
    }
    
    //set the barX
    maxLabelWidth = maxLabelWidth + 20.0;
    barX = maxLabelWidth + 60.0;
    
    //reset the frame
    CGRect myFrame = self.frame;
    myFrame.size.height = chartH;
    self.frame = myFrame;
    
    //build the bars
    for(int i=0; i<arrBarData.count; i++) {
        
        //set up some holders
        UIColor* barColor;
        int incrementWhat = 0;
        
        //add labels
        if (barStyle ==1) {
            
            UILabel* thisBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, maxLabelWidth, 30.0)];
            thisBarLabel.text = [NSString stringWithFormat:@"%@: (%@)",[arrBarLabels objectAtIndex:i], [arrBarData objectAtIndex:i]];
            thisBarLabel.textColor = [colorManager setColor:51.0 :51.0 :51.0];
            thisBarLabel.font = [UIFont fontWithName:@"Helvetica" size: 16.0];
            thisBarLabel.textAlignment = NSTextAlignmentLeft;
            thisBarLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:thisBarLabel];
        }
        
        //get the bar value
        float  barValue = [[self stripDollarSign:[arrBarData objectAtIndex:i]] floatValue] * 10;
                
        if (barStyle == 0) {
            //vertical bars
            barW = 20.0;
            barH = barValue;
        } else {
            barH = 20.0;
            barW = barValue;
            incrementWhat = 1;
        }
        
        //this needs to be more dynamic
        if (i==0) {
            barColor = [arrColorSets objectAtIndex:0];
        } else if (i==1) {
            barColor = [arrColorSets objectAtIndex:1];
        } else if (i==2) {
            barColor = [arrColorSets objectAtIndex:5];
        }
        
        UIView* vThisBar;
        if (barStyle ==0) { 
            vThisBar = [[UIView alloc] initWithFrame:CGRectMake(barX, self.frame.size.height-barH, barW, barH)];
        } else {
            vThisBar = [[UIView alloc] initWithFrame:CGRectMake(barX, barY, barW, barH)];
        }
        
        vThisBar.backgroundColor = barColor;
        
        
        [self addSubview:vThisBar];
        
        if (incrementWhat == 0) {
            barX = barX + 30.0;
        } else {
            barY = barY + 30.0;
            labelY = labelY + 30.0;
        }
        
    }
        
}

- (NSString*) stripSymbols : (NSString* ) stringToClean {
    
    NSString * strippedNumber = [stringToClean stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [stringToClean length])];
    
    return strippedNumber;
    
}

- (NSString*) stripDollarSign : (NSString*) stringToStrip {
    
    //check to see if the number is already formatted correctly
    NSRange dollarSignCheck = [stringToStrip rangeOfString:@"$"];
    //only strip it if it has the $
    if (dollarSignCheck.location != NSNotFound) {
        
        NSString* cleanedString = [stringToStrip substringWithRange:NSMakeRange(1, stringToStrip.length-1)];
        return cleanedString;
    }
    
    return 0;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
