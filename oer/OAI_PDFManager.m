//
//  OAI_PDFManager.m
//  EUS Calculator
//
//  Created by Steve Suranie on 2/11/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_PDFManager.h"

@implementation OAI_PDFManager {
    
    CGSize pageSize;
}



+(OAI_PDFManager *)sharedPDFManager {
    
    static OAI_PDFManager* sharedPDFManager;
    
    @synchronized(self) {
        
        if (!sharedPDFManager)
            
            sharedPDFManager = [[OAI_PDFManager alloc] init];
        
        return sharedPDFManager;
        
    }
    
}

-(id)init {
    return [self initWithAppID:nil];
}

-(id)initWithAppID:(id)input {
    if (self = [super init]) {
        
        /* perform your post-initialization logic here */
        colorManager = [[OAI_ColorManager alloc] init];
        stringManager = [[OAI_StringManager alloc] init];
        fileManager = [[OAI_FileManager alloc] init];
    }
    return self;
}

- (void) makePDF : (NSString*) fileName : (NSDictionary*) dictResults {
    
    pageSize = CGSizeMake(612, 792);
    
    _strPDFJustCreated = fileName;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName:dictResults];
    
}

- (void) generatePdfWithFilePath: (NSString *)thefilePath : (NSDictionary*) dictResults {
    
    //get which items we are going to list
    BOOL showALDAHOL = NO;
    BOOL showAcecide = NO;
    BOOL showCompetitor = NO;
    
    for(int i=0; i<_arrEmailCheckboxes.count; i++) {
        
        OAI_SimpleCheckbox* thisCheckbox = [_arrEmailCheckboxes objectAtIndex:i];
        
        NSString* strThisCheckbox = thisCheckbox.elementID;
        if([strThisCheckbox rangeOfString:@"ALDAHOL"].location != NSNotFound) {
            if ([thisCheckbox.isChecked isEqualToString:@"YES"]) {
                showALDAHOL = YES;
            }
        } else if ([strThisCheckbox rangeOfString:@"Acecide"].location != NSNotFound) {
            if ([thisCheckbox.isChecked isEqualToString:@"YES"]) {
                showAcecide = YES;
            }
        } else {
            if ([thisCheckbox.isChecked isEqualToString:@"YES"]) {
                showCompetitor = YES;
            }
        }
    }
    
    //set up our font styles
    UIFont* headerFont = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    UIFont* contentFont = [UIFont fontWithName:@"Helvetica" size:13.0];
    UIFont* tableFont = [UIFont fontWithName:@"Helvetica" size:8.0];
    UIFont* tableFontBold = [UIFont fontWithName:@"Helvetica" size:10.0];
    
    //set up a some constraints
    CGSize pageConstraint = CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset);
    
    //set up a color holdr
    UIColor* textColor;
    UIColor* clrOlympusBlue = [colorManager setColor:8.0 :16.0 :123.0];
    UIColor* clrDarkGray = [colorManager setColor:51.0 :51.0 :51.0];
    UIColor* borderColor;
    
    //Olympus logo
    UIImage* imgLogo = [UIImage imageNamed:@"OA_img_logo_iPadOptimized.png"];
    
    //for bars
    float lineWidth;
    
    //border
    CGRect borderFrame;
    CGRect textFrame;
    
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    BOOL done = NO;
        
    do {
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //add the olympus logo to top of page
        CGRect imgLogoFrame = CGRectMake(312-(imgLogo.size.width/2), (pageSize.height/3), imgLogo.size.width, imgLogo.size.height);
        [self drawImage:imgLogo :imgLogoFrame];
        
        //page title
        NSString* strPDFTitle = [NSString stringWithFormat:@"Operational Cost Projections With the Olympus OER-Pro for %@", _strFacilityName];
        
        
        textColor = clrOlympusBlue;
        CGSize PDFTitleSize = [strPDFTitle sizeWithFont:headerFont constrainedToSize:pageConstraint lineBreakMode:NSLineBreakByWordWrapping];
        CGRect PDFTitleFrame = CGRectMake((pageSize.width/2)-(PDFTitleSize.width/2), imgLogoFrame.origin.y + imgLogoFrame.size.height + 50.0, PDFTitleSize.width, PDFTitleSize.height);
        [self drawText:strPDFTitle :PDFTitleFrame :headerFont :textColor :0];
        
        /*************************PAGE 1*********************************/
        
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //add some intro text
        NSString* introText = [NSString stringWithFormat:@"Investing in Automatic Endoscope Reprocessing (AER) technology is an important decision to all organizations using flexible endoscopes. Understanding the benefits and costs associated with ownership of AER technology is critical to maximizing revenue and ensuring patient safety. That's why Olympus developed the Olympus OER-Pro Operational Cost Calculator.\n\nThe OER-Pro can be a compelling business proposition and a major addition to your existing portfolio of cleaning, disinfecting and sterilization products. In an effort to assist our current and prospective customers with their own analyses, Olympus has developed a flexible and tailored OER-Pro Operational Cost Calculator.\n\nThe OER-Pro is easier, faster, and more reliable to its competitor class and offers a full range of features and functions to consider when performing your analysis:\n\n• Compact single basin design allows you to reprocess up to two scopes at a time.\n• Reprocessing times as low as 26 minutes\n• Elimination of 7 of 11 manual reprocessing steps (FDA Approved)\n• RFID scanning technology that quickly and easily gathers scope model, serial number and technician ID.\n• Two dedicated High Level Disinfectant (HLD) options validated for material compatibility.\n• Optional data management capabilities allow you to efficiently manage cycle data.\n• Flexible financial options tailored to meet your needs\n• Accredited Biomed and technician training courses offered through Olympus University\n• Olympus offers 24/7 technical support\n• Our customers can utilize web portals for repair history and equipment information\n• Our broad Field Support Team is available to serve your needs\n\nThis calculator illustrates operational cost projection comparisons of the OER-Pro based on specific cost assumptions.  This tool is designed to be flexible and to take into account your unique customer information.\n\nThank you for your time and interest in Olympus' products and solutions. At Olympus, we appreciate the opportunity to partner with our customers to provide the most advanced and efficient care to your patients.  We look forward to doing business with you.\nBest regards,\n"];
        
        
        
        CGSize introTextSize = [introText sizeWithFont:contentFont constrainedToSize:pageConstraint lineBreakMode:NSLineBreakByWordWrapping];
        CGRect introTextFrame = CGRectMake(kMarginInset*2, 40.0, introTextSize.width, introTextSize.height);
        textColor = clrOlympusBlue;
        [self drawText:introText :introTextFrame :contentFont:textColor:0];
        
        /*************************PAGE 2*********************************/
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //table title
        NSString* strAnnualProcedures = [NSString stringWithFormat:@"Annual Volume: %@", [dictResults objectForKey:@"Annual Procedures"]];
        textColor = clrDarkGray;
        CGSize annualProceduresSize = [strAnnualProcedures sizeWithFont:headerFont];
        CGRect tableTitleFrame = CGRectMake(kMarginInset, kMarginInset*2, annualProceduresSize.width, 30.0);
        [self drawText:strAnnualProcedures :tableTitleFrame :headerFont:textColor:1];
        
        //results headers
        NSArray* arrResultsHeaders = [dictResults objectForKey:@"Results Table Headers"];
        
        float cellX = kMarginInset;
        float cellY = tableTitleFrame.origin.y+tableTitleFrame.size.height + 5.0;
        float cellW = 0.0;
        float cellH = 30.0;
        
        for(int i=0; i<arrResultsHeaders.count; i++) {
            
            BOOL showHeader = NO;
            NSString* strThisHeader = [arrResultsHeaders objectAtIndex:i];
            
            //determine if the header should be displayed or not
            if (i==1) {
                if (showALDAHOL) {
                    showHeader = YES;
                }
            } else if (i==2) {
                if (showAcecide) {
                    showHeader = YES;
                }
            } else if (i==3) {
                if (showCompetitor) {
                    showHeader = YES;
                    strThisHeader = _strSelectedCompetitor;
                }
            } else if (i==0) {
                showHeader = YES;
            }
            
            //build backgrounds
            if (i==0) {
                cellW = 190.0;
                
            } else {
                cellW = 126.0;
            }
            
            if(showHeader) {
                
                //set cgsize
                CGSize cellConstraint = CGSizeMake(cellW-2, 999.0);
                
                //make border rectangle
                borderColor = [UIColor whiteColor];
                
                //make border rect
                borderFrame = CGRectMake(cellX, tableTitleFrame.origin.y+tableTitleFrame.size.height + 5.0, cellW, kLineWidth*30);
                
                [self drawBorder:borderColor:borderFrame];
                
                
                //file the background color
                CGPoint headerBarStartPoint = CGPointMake(cellX, tableTitleFrame.origin.y + tableTitleFrame.size.height+20);
                CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, tableTitleFrame.origin.y + tableTitleFrame.size.height+20);
                lineWidth = kLineWidth*30;
                [self drawLine:lineWidth:clrOlympusBlue:headerBarStartPoint:headerBarEndPoint];
                
                //add the header text
                CGRect textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
                textColor = [UIColor whiteColor];
                [self drawText:strThisHeader :textFrame :tableFontBold :textColor :1];
                
                cellX = cellX + cellW;
                
            }
            
        }
        
        //add table content
        
        //results content
        NSArray* arrResultsRowHeaders = [dictResults objectForKey:@"Results Row Headers"];
        //NSArray* arrResults = [dictResults objectForKey:@""];
        
        
        //reset coords
        cellY = cellY + cellH;
        cellW = 190.0;
        cellX = kMarginInset;
        
        for(int i=0; i<arrResultsRowHeaders.count; i++) {
            
            //set cgsize
            CGSize cellConstraint = CGSizeMake(cellW-2, 999.0);
            
            NSString* strThisHeader = [arrResultsRowHeaders objectAtIndex:i];
            CGSize thisHeaderSize = [strThisHeader sizeWithFont:tableFontBold constrainedToSize:cellConstraint lineBreakMode:NSLineBreakByWordWrapping];
            
            //make border rectangle
            borderColor = [UIColor grayColor];
            
            //make border rect
            borderFrame = CGRectMake(cellX, cellY, cellW, kLineWidth*20);
            
            [self drawBorder:borderColor:borderFrame];
            
            
            //set alternating colors
            UIColor* backgroundColor;
            if (i%2) {
                backgroundColor = [colorManager setColor:253.0 :236.0 :190.0];
            } else {
                backgroundColor = [colorManager setColor:230.0 :230.0 :230.0];
            }
            
            //fill the background color
            CGPoint headerBarStartPoint = CGPointMake(cellX, cellY+10.0);
            CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, cellY+10.0);
            lineWidth = kLineWidth*20;
            [self drawLine:lineWidth:backgroundColor:headerBarStartPoint:headerBarEndPoint];
            
            //add the row header text
            CGRect textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
            textColor = clrDarkGray;
            [self drawText:strThisHeader :textFrame :tableFontBold :textColor :1];
            
            //get the correct results array for the row header
            NSArray* arrResultsData = [[NSArray alloc] init];
            if ([strThisHeader rangeOfString:@"Service"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Service Results"];
            } else if ([strThisHeader rangeOfString:@"Chemical"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Chemical Results"];
            } else if ([strThisHeader rangeOfString:@"Detergent"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Detergent Results"];
            } else if ([strThisHeader rangeOfString:@"Test Strips"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Test Strip Results"];
            } else if ([strThisHeader rangeOfString:@"Filters"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Filter Results"];
            } else if ([strThisHeader rangeOfString:@"Labor"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Labor Results"];
            } else if ([strThisHeader rangeOfString:@"Total"].location !=NSNotFound) {
                arrResultsData = [dictResults objectForKey:@"Total Results"];
            }
            
            cellX = cellX + cellW;
            cellW = 126.0;
            cellH = 20.0;
            
            BOOL showCell = NO;
            
            //loop through the results array
            for(int x =0; x<arrResultsData.count; x++) {
                
                //determine if the header should be displayed or not
                if (x==0) {
                    if (showALDAHOL) {
                        showCell = YES;
                    }
                } else if (x==1) {
                    if (showAcecide) {
                        showCell = YES;
                    }
                } else if (x==2) {
                    if (showCompetitor) {
                        showCell = YES;
                    }
                }
                
                
                
                NSString* strCellValue = [arrResultsData objectAtIndex:x];
                
                if (showCell) {
                    
                    //make border rectangle
                    borderColor = [UIColor grayColor];
                    
                    //make border rect
                    borderFrame = CGRectMake(cellX, cellY, cellW, kLineWidth*20);
                    
                    [self drawBorder:borderColor:borderFrame];
                    
                    //fill the background color
                    CGPoint headerBarStartPoint = CGPointMake(cellX, cellY+10.0);
                    CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, cellY+10.0);
                    lineWidth = kLineWidth*20;
                    [self drawLine:lineWidth:backgroundColor:headerBarStartPoint:headerBarEndPoint];
                    
                    //add the row header text
                    textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
                    textColor = clrDarkGray;
                    [self drawText:strCellValue :textFrame :tableFontBold :textColor :1];
                    
                    cellX = cellX + cellW;
                }
                
                showCell = NO;
                
            }
            
            //increment y
            cellY = cellY + 20;
            cellW = 190.0;
            cellX = kMarginInset;
            
        }
        
        //add the cost notes
        NSString* strCostNotes = @"The additional cost of the OER-Pro with Acecide may be offset by the time and safety improvements noted in this document.\n\nThe OER-Pro is designed to reprocess two endoscopes per cycle. The \"cost per scope\" reflects the cost for reprocessing one scope when scopes are reprocessed per cycle.\n\nThe number of cycles and the cost of filters per case varies depending on water quality and is difficult to project. Filter costs for an Olympus-purchased prefiltration system are included in this tool. Additionally, other factors such as test strip interpretation, selected chemistry and other environmental factors great influence the number of cycles before a change is required. The projected numbers provided in this calculator are only an estimate. Olympus suggests meeting with your Clinical Bioengineering Department to address local issues related to this expense.";
        
        CGSize costNoteSize = [strCostNotes sizeWithFont:tableFont constrainedToSize:CGSizeMake(pageSize.width-(kMarginInset*2), 999.0) lineBreakMode:NSLineBreakByWordWrapping];
        
        //add the row header text
        textFrame = CGRectMake(kMarginInset, cellY+2.0, costNoteSize.width, costNoteSize.height);
        textColor = clrDarkGray;
        [self drawText:strCostNotes :textFrame :tableFont :textColor :0];
        
        //time savings table
        //table title
        NSString* strTimeSavings = @"Time Savings";
        CGSize timeSavingsSize = [strTimeSavings sizeWithFont:headerFont];
        tableTitleFrame = CGRectMake(kMarginInset, textFrame.origin.y + textFrame.size.height + 10.0, timeSavingsSize.width, 30.0);
        [self drawText:strTimeSavings :tableTitleFrame :headerFont:textColor:1];
        
        NSArray* arrTypes = [dictResults objectForKey:@"Time Savings Headers"];
        
        //reset cell coords
        cellY = tableTitleFrame.origin.y+tableTitleFrame.size.height + 5.0;
        cellX = kMarginInset;
        cellW = 190.0;
        cellH = 30.0;
        
        NSArray* arrTimeSavingsHeaders = [dictResults objectForKey:@"Time Savings Headers"];
        NSString* strHeaderValue;
        
        for(int i=0; i<arrTypes.count+1; i++) {
            
            BOOL showHeader = NO;
            
            //set the cell width
            if (i==0) {
                cellW = 190.0;
                showHeader = YES;
                strHeaderValue = @"";
            } else {
                cellW = 126.0;
            }
            
            //determine if the header should be displayed or not
            if (i==1) {
                if (showALDAHOL) {
                    showHeader = YES;
                    strHeaderValue = [arrTimeSavingsHeaders objectAtIndex:0];
                }
            } else if (i==2) {
                if (showAcecide) {
                    showHeader = YES;
                    strHeaderValue = [arrTimeSavingsHeaders objectAtIndex:1];
                }
            } else if (i==3) {
                if (showCompetitor) {
                    showHeader = YES;
                    strHeaderValue = _strSelectedCompetitor;
                }
            } else if (i==0) {
                showHeader = YES;
                strHeaderValue = @"";
            }
            
            if(showHeader) {
                
                 //set cgsize
                CGSize cellConstraint = CGSizeMake(cellW-2, 999.0);
                
                //make border rectangle
                borderColor = [UIColor whiteColor];
                
                //make border rect
                borderFrame = CGRectMake(cellX, tableTitleFrame.origin.y+tableTitleFrame.size.height + 5.0, cellW, kLineWidth*30);
                
                [self drawBorder:borderColor:borderFrame];
                
                //fill the background color
                CGPoint headerBarStartPoint = CGPointMake(cellX, tableTitleFrame.origin.y + tableTitleFrame.size.height+20);
                CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, tableTitleFrame.origin.y + tableTitleFrame.size.height+20);
                lineWidth = kLineWidth*30;
                [self drawLine:lineWidth:clrOlympusBlue:headerBarStartPoint:headerBarEndPoint];
                
                //add the header text
                CGRect textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
                textColor = [UIColor whiteColor];
                [self drawText:strHeaderValue :textFrame :tableFontBold :textColor :1];
                
                //increment x
                cellX = cellX + cellW;
                
                //reset show header
                showHeader = NO;
                
            }
           
        }
        
        //time savings row headers
        
        //reset the coords
        cellX = kMarginInset;
        cellY = cellY + 30.0;
        cellW = 190.0;
        cellH = 20.0;
        
        NSArray* arrTimeSavingRowHeaders = [dictResults objectForKey:@"Time Savings Row Headers"];
        NSArray* arrCellValues = [[NSArray alloc] init];
        
        for(int i=0; i<arrTimeSavingRowHeaders.count; i++) {
            
            BOOL showCell = NO;
            
            NSString* strTimeRowHeader = [arrTimeSavingRowHeaders objectAtIndex:i];
            
            //make border rectangle
            borderColor = [UIColor grayColor];
            
            //make border rect
            borderFrame = CGRectMake(cellX, cellY, cellW, kLineWidth*20);
            
            [self drawBorder:borderColor:borderFrame];
            
            //set alternating colors
            UIColor* backgroundColor;
            if (i%2) {
                backgroundColor = [colorManager setColor:253.0 :236.0 :190.0];
            } else {
                backgroundColor = [colorManager setColor:230.0 :230.0 :230.0];
            }
            
            //fill the background color
            CGPoint headerBarStartPoint = CGPointMake(cellX, cellY+10.0);
            CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, cellY+10.0);
            lineWidth = kLineWidth*20;
            [self drawLine:lineWidth:backgroundColor:headerBarStartPoint:headerBarEndPoint];
            
            textColor = clrDarkGray;
            textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
            [self drawText:strTimeRowHeader :textFrame :tableFontBold:textColor:1];
            
            //get the time savings values
            arrCellValues =  [dictResults objectForKey:strTimeRowHeader];
            
            for(int x=0; x<arrCellValues.count; x++) {
                
                //resize cellW
                cellW = 126.0;
                
                //increment x
                if (x>0) {
                    cellX = cellX + cellW;
                } else {
                    cellX = cellX + 190.0;
                }
                
                //determine if the header should be displayed or not
                if (x==0) {
                    if (showALDAHOL) {
                        showCell = YES;
                    }
                } else if (x==1) {
                    if (showAcecide) {
                        showCell = YES;
                    }
                } else if (x==2) {
                    if (showCompetitor) {
                        showCell = YES;
                    }
                }
                
                if (showCell) {
                    
                    NSString* strCellValue = [arrCellValues objectAtIndex:x];
                    
                    //make border rectangle
                    borderColor = [UIColor grayColor];
                    
                    //make border rect
                    borderFrame = CGRectMake(cellX, cellY, cellW, kLineWidth*20);
                    
                    [self drawBorder:borderColor:borderFrame];
                    
                    //fill the background color
                    CGPoint headerBarStartPoint = CGPointMake(cellX, cellY+10.0);
                    CGPoint headerBarEndPoint = CGPointMake(cellX + cellW, cellY+10.0);
                    lineWidth = kLineWidth*20;
                    [self drawLine:lineWidth:backgroundColor:headerBarStartPoint:headerBarEndPoint];
                    
                    textColor = clrDarkGray;
                    textFrame = CGRectMake(cellX, cellY+2.0, cellW, cellH);
                    [self drawText:strCellValue :textFrame :tableFontBold:textColor:1];
                    
                    
                    
                }
                
                cellW = 190.0;
                showCell = NO;

            }
            
            //increment y
            cellY = cellY + 20.0;
            
            //reset x & w
            cellX = kMarginInset;
            
        }
        
        float textX = kMarginInset;
        float textY = cellY + 10.0;
        
        //add informational text to bottom of time savings table
        NSMutableString* strInfoText = [[NSMutableString alloc] initWithString:@"OER-Pro Time Values:\n\nOur intimate knowledge of endoscope design allows us to use proprietary technologies to provide you with an enhanced reprocessing experience. As part of that experience, the OER-Pro eliminates 7 of the 11 recommended manual cleaning steps."];
        
        if (_strSelectedCompetitor) {
            
            [strInfoText appendString:_strALDAHOLSavings];
            
            [strInfoText appendString:_strAcecideSavings];
            
            [strInfoText appendString:@"\n\nAcecide-C:\nConservatively Acecide-C saving estimate vs. ALDAHOL is: 3 minutes\nAnnual staff time savings is estimated to be at least: 100 hours\nAt $15 per hour, this annual savings totals: $1500"];
        } else {
            
            [strInfoText appendString:@"\n\nALDAHOL 1.8:\nConservatively ALDAHOL 1.8 saving estimate vs. Competitor AER is N/A\nAnnual staff time savings is estimated to be at least: N/A\nAt $15 per hour, this annual savings totals: N/A"];
            
            [strInfoText appendString:@"\n\nAcecide-C:\nConservatively Acecide-C saving estimate vs. Competitor AER is N/A\nAnnual staff time savings is estimated to be at least: N/A\nAt $15 per hour, this annual savings totals: N/A"];
            
            [strInfoText appendString:@"\n\nAcecide-C:\nConservatively Acecide-C saving estimate vs. ALDAHOL is: 3 minutes\nAnnual staff time savings is estimated to be at least: 100 hours\nAt $15 per hour, this annual savings totals: $1500"];
            
        }

        
        
        
        CGSize infoSize = [strInfoText sizeWithFont:contentFont constrainedToSize:CGSizeMake(pageSize.width-(kMarginInset*2), 999.0) lineBreakMode:NSLineBreakByWordWrapping];
        
        textColor = clrDarkGray;
        textFrame = CGRectMake(textX, textY, infoSize.width, infoSize.height);
        [self drawText:strInfoText :textFrame :tableFont:textColor:0];
        
        //add disclaimer
        NSString* strDisclaimer = stringManager.strDisclaimer;
        CGSize disclaimerSize = [strDisclaimer sizeWithFont:contentFont constrainedToSize:CGSizeMake(pageSize.width-(kMarginInset*2), 999.0) lineBreakMode:NSLineBreakByWordWrapping];
        
        textColor = clrDarkGray;
        textFrame = CGRectMake(textX, textFrame.origin.y + textFrame.size.height, disclaimerSize.width, disclaimerSize.height);
        [self drawText:strDisclaimer :textFrame :tableFont:textColor:0];
        
        
        
        done = YES;
    
    } while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
   
    
    //move the marketing pdf to the documents directory
    [fileManager moveFileToDocDirectory:@"OER_MarketingContent.pdf":@"There was a problem creating the PDF file!"];
    
    //merge the pdf just created and the marketing info pdf
    //[fileManager mergerPDFFiles:_strPDFJustCreated :@"OER_MarketingContent.pdf"];
    
}

#pragma mark - Drawing Methods

- (void) drawText : (NSString* ) textToDraw : (CGRect) textFrame : (UIFont*) textFont : (UIColor*) textColor : (int) textAlignment {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(currentContext, textColor.CGColor);
    
    int myTextAlignment = textAlignment;
    
    [textToDraw drawInRect:textFrame withFont:textFont lineBreakMode:NSLineBreakByWordWrapping alignment:myTextAlignment];
}

- (void) drawImage : (UIImage*) imageToDraw : (CGRect) imageFrame  {
    
   [imageToDraw drawInRect:imageFrame];
}

- (void) drawLine : (float) lineWidth : (UIColor*) lineColor : (CGPoint) startPoint : (CGPoint) endPoint  {
    
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, lineWidth);
    CGContextSetStrokeColorWithColor(currentContext, lineColor.CGColor);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawBorder : (UIColor*) borderColor :  (CGRect) rectFrame {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
    
}

#pragma mark - Data Gather

- (float) getStringHeight : (NSString* ) stringToMeasure : (float) widthConstraint : (UIFont*) thisFont {
    
    CGSize stringConstraint = CGSizeMake(widthConstraint, 9999.0);
    CGSize stringSize = [stringToMeasure sizeWithFont:thisFont constrainedToSize:stringConstraint lineBreakMode:NSLineBreakByWordWrapping];
    
    return stringSize.height;
    
}

- (float) getMaxHeaderHeight : (NSArray*) headers : (UIFont*) font {
    
    //set a max height for the headers
    float maxHeaderH = 0.0;
    
    for(int i=0; i<headers.count; i++) {
        
        float thisConstraint;
        
        if (i==0) {
            thisConstraint = 140.0;
        } else {
            thisConstraint = (pageSize.width-(kMarginInset*2))/2;
        }
        
        float thisStringHeight = [self getStringHeight:[headers objectAtIndex:i] :thisConstraint:font];
        
        if (thisStringHeight > maxHeaderH) {
            maxHeaderH = thisStringHeight;
        }
    }
    
    return maxHeaderH;

}

- (void) setHeaderText : (NSArray*) headers : (UIFont*) font : (float) headerX : (float) headerY : (float) headerW : (float) headerH : (UIColor*) textColor {
    
    for(int i=0; i<headers.count; i++) {
        
        NSString* strThisHeader = [headers objectAtIndex:i];
        
        if (i>0) {
            headerX = headerX + headerW + 5.0;
            
            if (headerW == 140.0) { 
                headerW = 200.0;
            } else if (headerW == 80.0) {
                if (i>1) { 
                    headerW = 140.0;
                    headerX = headerX + 15.0;
                }
            } else if (headerW == 240.0) {
                headerW = 124.0;
            }
        }
        
        CGRect thisHeaderFrame = CGRectMake(headerX, headerY, headerW, headerH);
        [self drawText:strThisHeader :thisHeaderFrame :font:textColor:0];
    }
}

- (void) buildAlternatingTableRows : (NSArray*) rowHeaders : (UIColor* ) color1 : (UIColor* ) color2 : (float) rowX : (float) rowY : (float) endRowX : (float) endRowY : (float) lineWidth {
    
    for(int i=0; i<rowHeaders.count; i++) {
    
        //build a row
        UIColor* rowColor;
        if (i%2) {
            rowColor = color1;
        } else {
            rowColor = color2;
        }
    
        if(i>0) {
            rowY = rowY + 40.0;
            endRowY = endRowY + 40.0;
        }
        
        CGPoint rowStartPoint = CGPointMake(rowX, rowY);
        CGPoint rowEndPoint = CGPointMake(endRowX, endRowY);
        [self drawLine:lineWidth:rowColor:rowStartPoint:rowEndPoint];
        
    }

    
}

- (void) setRowText : (NSArray* ) rowCellContents : (float) strX : (float) strY : (float) strW : (float) strH : (UIColor*) textColor : (UIFont*) font {
    
    for(int r=0; r<rowCellContents.count; r++) {
        
        NSString* thisRowItem = [rowCellContents objectAtIndex:r];
        
        if (r>0) {
            
            //increment x
            strX = strX + strW + 5.0;
            
            if (strW == 140) { 
                //change row w
                strW = 200.0;
            } else if (strW == 80 && r>1) {
                strW = 140.0;
                strX = strX + 15.0;
            }
        }
        
        CGRect thisRowCellFrame = CGRectMake(strX, strY, strW, strH);
        [self drawText:thisRowItem :thisRowCellFrame :font:textColor:0];
        
    }

    
}

- (NSArray* ) gatherCellData : (NSDictionary*) theResults : (NSString* ) key {
    
    //set up an array to hold the keys to pul from theResults
    NSMutableArray* keyArray = [[NSMutableArray alloc] init];
    for(int i=0; i<3; i++) {
        [keyArray addObject:[NSString stringWithFormat:@"%@ Year %i", key, i+1]];
    }
    
    
    
    //loop through results
    for(NSString* thisKey in theResults) {
     
        if([thisKey hasPrefix:key]) {
            NSArray* thisRowCellData = [[NSArray alloc] initWithObjects:[theResults objectForKey:[keyArray objectAtIndex:0]], [theResults objectForKey:[keyArray objectAtIndex:1]], [theResults objectForKey:[keyArray objectAtIndex:2]],nil];
            
            return thisRowCellData;
        }
        
    }
    
    
    NSArray* thisRowCellData;
    return thisRowCellData;
    
}

@end
