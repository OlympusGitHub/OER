//
//  ViewController.m
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "ViewController.h"

#define PAGEBORDER 40.0

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    hasItems = YES;    
    
    /**************MANAGERS****************/
    calculator = [[OAI_Calculations alloc] init];
    colorManager = [[OAI_ColorManager alloc] init];
    fileManager =  [[OAI_FileManager alloc] init];
    stringManager =   [[OAI_StringManager alloc] init];
    pdfManager = [[OAI_PDFManager alloc] init];
    
    /**************NOTIFICATION CENTER****************/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"theMessenger"object:nil];
    
    /*************************************
     REGISTER FOR NOTIFICATIONS FOR KEYBOARD
     **************************************/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /**************FONTS****************/
    headerFont = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    cellFont = [UIFont fontWithName:@"Helvetica" size:18.0];
    
    /**********COLORS******************/
    clrOlympusYellow = [colorManager setColor:233.0 :178.0 :38.0];
    clrDarkGrey = [colorManager setColor:51:51 :51];
    clrLightGrey = [colorManager setColor:204.0 :204.0 :204.0];
    
    /*************INITS**************/
    dictTextFields = [[NSMutableDictionary alloc] init];
    dictResults = [[NSMutableDictionary alloc] init];
    dictResultCells = [[NSMutableDictionary alloc] init];
    dictCompetitors = [[NSMutableDictionary alloc] init];
    dictInitialValues = [[NSMutableDictionary alloc] init];
    
    //build the competitors dictionary
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
        @"2", @"Pre-Cleaning",
        @"4", @"Leakage Test",
        @"5", @"Manaual Cleaning",
        @"3", @"AER Processing",
        @"32", @"Post AER Processing", 
        nil]
    forKey:@"Current AER Estimates"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"33", @"Post AER Processing", 
         nil]
    forKey:@"Advanced Sterilization Products (ASP) Evotech"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"32", @"Post AER Processing",
         nil]
    forKey:@"Custom Ultrasonics System 83 Plus"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"42", @"Post AER Processing",
         nil]
    forKey:@"Steris System 1"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"32", @"Post AER Processing",
         nil]
    forKey:@"Steris System IE"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"32", @"Post AER Processing",
         nil]
    forKey:@"Steris Reliance"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"30", @"Post AER Processing",
         nil]
    forKey:@"DSD 91-E"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"30", @"Post AER Processing",
         nil]
    forKey:@"Medivators DSD-20ILT"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"22", @"Post AER Processing",
         nil]
    forKey:@"Medivators DSD-Edge"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"28", @"Post AER Processing",
         nil]
    forKey:@"Medivators Advantage Plus"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"28", @"Post AER Processing",
         nil]
    forKey:@"CER-1"];
    
    [dictCompetitors setObject: [[NSDictionary alloc] initWithObjectsAndKeys:
         @"2", @"Pre-Cleaning",
         @"4", @"Leakage Test",
         @"5", @"Manaual Cleaning",
         @"3", @"AER Processing",
         @"28", @"Post AER Processing",
         nil]
    forKey:@"CER-2"];
    
    arrCompetitorNames = [[NSArray alloc] initWithObjects:@"Current AER Estimates", @"Advanced Sterilization Products (ASP) Evotech", @"Custom Ultrasonics System 83 Plus", @"Steris System 1", @"Steris System IE", @"Steris Reliance", @"DSD 91-E", @"Medivators DSD-20ILT", @"Medivators DSD-Edge", @"Medivators Advantage Plus", @"CER-1", @"CER-2", nil];
    
    //set main view (so we can over ride touchesBegan
    vMainView = [[OAI_View alloc] initWithFrame:self.view.frame];

    
    /***********************************
     TOP BAR
     ***********************************/
    
    titleBarManager = [[OAI_TitleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 40.0)];
    titleBarManager.titleBarTitle = @"OER Comparison Calculator";
    [titleBarManager buildTitleBar];
    [vMainView addSubview:titleBarManager];
    
    scNav = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, titleBarManager.frame.origin.y + titleBarManager.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-titleBarManager.frame.size.height)];
    [scNav setContentSize: CGSizeMake(768*3, self.view.frame.size.height-titleBarManager.frame.size.height)];
    scNav.scrollEnabled = NO;
    scNav.delegate = self;
    scNav.canCancelContentTouches = NO;
    [scNav setDelaysContentTouches:NO];
    [scNav setContentSize:CGSizeMake(768*3, 1004)];
    
    [vMainView addSubview:scNav];
    
    //add the scroll view pages
    for(int i=0; i<3; i++) {
        
        //main page
        if (i==0) {
            
            UIView* vUserInputs = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 260.0)];
            vUserInputs.backgroundColor = clrDarkGrey;
            vUserInputs.layer.shadowColor = [UIColor blackColor].CGColor;
            vUserInputs.layer.shadowOffset = CGSizeMake(2.0, 2.0);
            vUserInputs.layer.shadowOpacity = .75;
            
            //set the string and size
            NSString* strOERSpecifics = @"Olympus OER Pro Specifics";
            CGSize OERSpecificsSize = [strOERSpecifics sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:24.0]];
            
            //set the label
            UILabel* lblOERSpecifics = [[UILabel alloc] initWithFrame:CGRectMake((vUserInputs.frame.size.width/2)-(OERSpecificsSize.width/2), 20.0, OERSpecificsSize.width, OERSpecificsSize.height)];
            lblOERSpecifics.text = strOERSpecifics;
            lblOERSpecifics.textColor = clrOlympusYellow;
            lblOERSpecifics.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
            lblOERSpecifics.backgroundColor = [UIColor clearColor];
            lblOERSpecifics.layer.cornerRadius = 10;
            [lblOERSpecifics.layer setMasksToBounds:YES];
            
            [vUserInputs addSubview:lblOERSpecifics];
            
            //build top table
            //table row headers
            NSArray* arrSpecificsRowHeaders = [[NSArray alloc] initWithObjects:@"Procedures Per Year:", @"Recommended Number of OER-Pros:", @"Number of Scopes Per Basin:", @"Estimated Number of Cycles Per Year:", nil];
            NSArray* arrSpecificsRowValues = [[NSArray alloc] initWithObjects:@"2000", @"0", @"1.75", @"0.0", nil];
            
            float rowX=40.0;
            float rowY = lblOERSpecifics.frame.origin.y + lblOERSpecifics.frame.size.height + 30.0;
            float maxRowW = 0.0;
            
            NSString* strThisRowHeader;
            CGSize thisRowHeaderSize;
            
            //get max row header width (cell 1)
            for(int i=0; i<arrSpecificsRowHeaders.count; i++) {
                
                strThisRowHeader = [arrSpecificsRowHeaders objectAtIndex:i];
                thisRowHeaderSize = [strThisRowHeader sizeWithFont:headerFont];
                
                if (thisRowHeaderSize.width > maxRowW) {
                    maxRowW = thisRowHeaderSize.width;
                }
            }
            
            //display the headers
            for(int i=0; i<arrSpecificsRowHeaders.count; i++) {
                
                //set the label border
                UIView* vLabelBorder = [[UIView alloc] initWithFrame:CGRectMake(rowX, rowY, thisRowHeaderSize.width + 8.0, 32.0)];
                vLabelBorder.layer.cornerRadius = 8.0;
                vLabelBorder.layer.borderWidth = 1.0;
                vLabelBorder.layer.borderColor = [colorManager setColor:204.0 :204.0 :204.0].CGColor;
                
                //set the label
                UILabel* lblRowHeader = [[UILabel alloc] initWithFrame:CGRectMake(4.0, 0.0, thisRowHeaderSize.width, 30.0)];
                lblRowHeader.text = [arrSpecificsRowHeaders objectAtIndex:i];
                lblRowHeader.textColor = [colorManager setColor:204.0 :204.0 :204.0];
                lblRowHeader.backgroundColor = [UIColor clearColor];
                lblRowHeader.font = headerFont;
                lblRowHeader.textAlignment = NSTextAlignmentRight;
                
                [vLabelBorder addSubview:lblRowHeader];
                [vUserInputs addSubview:vLabelBorder];
                
                //set the text fields
                OAI_TextField* thisTextEntry = [[OAI_TextField alloc] initWithFrame:CGRectMake(maxRowW + 70.0, rowY, 200.0, 30.0)];
                thisTextEntry.delegate = self;
                thisTextEntry.returnKeyType = UIReturnKeyDone;
                
                //id this textfield
                if (i==0) {
                    thisTextEntry.text = [arrSpecificsRowValues objectAtIndex:i];
                    thisTextEntry.textFieldTitle = @"Procedure Count";
                    thisTextEntry.textFieldInputType = 0;
                    [dictTextFields setObject:thisTextEntry forKey:thisTextEntry.textFieldTitle];
                } else if (i==1) {
                    thisTextEntry.text = [arrSpecificsRowValues objectAtIndex:i];
                    thisTextEntry.textFieldTitle = @"OER Count";
                    thisTextEntry.textFieldInputType = 0;
                    [dictTextFields setObject:thisTextEntry forKey:thisTextEntry.textFieldTitle];
                } else if (i==2) {
                    thisTextEntry.text = [arrSpecificsRowValues objectAtIndex:i];
                    thisTextEntry.textFieldTitle = @"Scopes Per Basin";
                    thisTextEntry.textFieldInputType = 0;
                    [dictTextFields setObject:thisTextEntry forKey:thisTextEntry.textFieldTitle];
                } else if (i==3)  {
                    thisTextEntry.text = [arrSpecificsRowValues objectAtIndex:i];
                    thisTextEntry.textFieldTitle = @"Annual Cycle Count";
                    thisTextEntry.textFieldInputType = 0;
                    [dictTextFields setObject:thisTextEntry forKey:thisTextEntry.textFieldTitle];
                }
                
                [vUserInputs addSubview:thisTextEntry];
                
                rowY = rowY + 45.0;
                
            }
            
            [scNav addSubview:vUserInputs];
            
            /********************TABLE HEADER**************************/
            
            //add a header bar
            UIView* vTableSection = [[UIView alloc] initWithFrame:CGRectMake(0.0, rowY + 10.0, vUserInputs.frame.size.width, self.view.frame.size.height-vUserInputs.frame.size.height)];
            vTableSection.backgroundColor = [UIColor whiteColor];
            
            //get the splits
            float barThird = scNav.frame.size.width/3;
            float barTwoThirds = barThird*2;
            float barNewThird = barTwoThirds/3;
            
            //add the header bar padding
            UIView* vHeaderBarPadding = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, barThird-1.0, 60.0)];
            vHeaderBarPadding.backgroundColor = clrOlympusYellow;
            
            UIButton* btnResults = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnResults setFrame:CGRectMake(30.0, 15.0, vHeaderBarPadding.frame.size.width-60, 30.0)];
            btnResults.layer.cornerRadius = 4.0f;
            [btnResults setTitle:@"Show Comparison" forState:UIControlStateNormal];
            btnResults.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btnResults setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnResults.backgroundColor = [colorManager setColor:8.0 :16.0 :123.0];
            btnResults.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
            [btnResults addTarget:self action:@selector(showComparison:) forControlEvents:UIControlEventTouchUpInside];
            [vHeaderBarPadding addSubview:btnResults];
            
            [vTableSection addSubview:vHeaderBarPadding];
            
            //set up headers
            arrTypes = [[NSArray alloc] initWithObjects:@"Olympus OER-Pro with ALDAHOL 1.8", @"Olympus OER-Pro with Acecide-C", @"Select A \nCompetitor", nil];
            
            //set up some coords
            float labelX = barThird;
            float labelW = barNewThird-1.0;
            OAI_Label* lblThisHeader;
            
            //loop
            for(int i=0; i<arrTypes.count; i++) {
                
                //set the last label width to be full size
                if (i==arrTypes.count-1) {
                    labelW = barNewThird+2.0;
                }
                
                //init the label
                lblThisHeader = [[OAI_Label alloc] initWithFrame:CGRectMake(labelX, 0.0, labelW, 60.0)];
                lblThisHeader.text = [arrTypes objectAtIndex:i];
                lblThisHeader.textColor = clrDarkGrey;
                lblThisHeader.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
                lblThisHeader.backgroundColor = clrOlympusYellow;
                lblThisHeader.numberOfLines = 0;
                lblThisHeader.lineBreakMode = NSLineBreakByWordWrapping;
                lblThisHeader.textAlignment = NSTextAlignmentCenter;
                
                if([[arrTypes objectAtIndex:i] isEqualToString:@"Select A \nCompetitor"]) {
                    
                    UITapGestureRecognizer* tgrMyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCompetitors:)];
                    tgrMyTap.delegate = self;
                    lblThisHeader.userInteractionEnabled = YES;
                    lblThisHeader.tag = 500;
                    [lblThisHeader addGestureRecognizer:tgrMyTap];
                    
                }
                
                [vTableSection addSubview:lblThisHeader];
                
                
                //increment x
                labelX = labelX + labelW + 1.0;
            }
            
            //add the scroll view
            scSections = [[OAI_ScrollView alloc] initWithFrame:CGRectMake(0.0, lblThisHeader.frame.origin.y + lblThisHeader.frame.size.height +2, vTableSection.bounds.size.width, vTableSection.frame.size.height-lblThisHeader.frame.size.height)];
            [scSections flashScrollIndicators];
            [vTableSection addSubview:scSections];
            
            //get the sections
            NSArray* arrSection = stringManager.arrSections;
            
            //get the header rows for each section
            NSArray* arrSectionRowHeaders = [[NSArray alloc] initWithObjects:stringManager.arrChemicalKeys, stringManager.arrDetergentKeys, stringManager.arrTestStripsKeys, stringManager.arrFiltersKeys, stringManager.arrServiceKeys,  stringManager.arrLaborKeys, stringManager.arrOperationKeys, nil];
            
            float sectionX = 0.0;
            float sectionY = 0.0;
            float sectionH = 0.0;
            float scrollH = 0.0;
            
            //loop through the sections
            for (int i=0; i<arrSection.count; i++) {
                
                //build section divider
                NSString* strThisSectionTitle = [arrSection objectAtIndex:i];
                
                OAI_Label* lblThisSectionTitle = [[OAI_Label alloc] initWithFrame:CGRectMake(sectionX, sectionY, vTableSection.frame.size.width, 30.0)];
                lblThisSectionTitle.text = strThisSectionTitle;
                lblThisSectionTitle.textColor = clrLightGrey;
                lblThisSectionTitle.backgroundColor = clrDarkGrey;
                lblThisSectionTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
                lblThisSectionTitle.textAlignment = NSTextAlignmentCenter;
                
                [scSections addSubview:lblThisSectionTitle];
                
                //increment the sectionH
                sectionH = sectionH + lblThisSectionTitle.frame.size.height;
                
                //get the row headers for this section
                NSArray* arrThisSectionRowHeaders =[arrSectionRowHeaders objectAtIndex:i];
                
                //loop through the row headers
                rowY = sectionY + 40.0;
                UILabel* lblSectionRowHeader;
                
                for(int x=0; x<arrThisSectionRowHeaders.count; x++) {
                    
                    //get the header
                    NSString* strThisSectionRowHeader = [arrThisSectionRowHeaders objectAtIndex:x];
                    
                    //set the size with a constraint
                    CGSize thisSectionSize = [strThisSectionRowHeader sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20] constrainedToSize:CGSizeMake((barThird-20.0), 999.0) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    //init the label
                    lblSectionRowHeader = [[UILabel alloc] initWithFrame:CGRectMake(20.0, rowY, thisSectionSize.width, thisSectionSize.height)];
                    lblSectionRowHeader.text = strThisSectionRowHeader;
                    lblSectionRowHeader.textColor = clrDarkGrey;
                    lblSectionRowHeader.textAlignment = NSTextAlignmentLeft;
                    lblSectionRowHeader.font = [UIFont fontWithName:@"Helvetica'" size:20.0];
                    lblSectionRowHeader.numberOfLines = 0;
                    lblSectionRowHeader.lineBreakMode = NSLineBreakByWordWrapping;
                    lblSectionRowHeader.backgroundColor = [UIColor clearColor];
                    
                    [scSections addSubview:lblSectionRowHeader];
                    
                    //add the textfields
                    float textFieldX = barThird;
                    float textFieldY = rowY;
                    
                    for(int y=0; y<3; y++) {
                        
                        //set up the text field id
                        NSString* strTextFieldID;
                        if (y==0) {
                            strTextFieldID = [NSString stringWithFormat:@"%@_%@_ALDAHOL", strThisSectionTitle, strThisSectionRowHeader];
                        } else if (y==1) {
                            strTextFieldID = [NSString stringWithFormat:@"%@_%@_AcecideC", strThisSectionTitle, strThisSectionRowHeader];
                        } else if (y==2) {
                            strTextFieldID = [NSString stringWithFormat:@"%@_%@_Competition", strThisSectionTitle, strThisSectionRowHeader];
                        }
                        
                        //text field input type
                        //set up text field numeric type 0=int, 1=%, 2=$, 3=decimal
                        int inputType;
                        if ([strTextFieldID rangeOfString:@"Discount"].location != NSNotFound) {
                            inputType = 1;
                        } else if ([strTextFieldID rangeOfString:@"Unit"].location != NSNotFound || [strTextFieldID rangeOfString:@"Use"].location != NSNotFound || [strTextFieldID rangeOfString:@"Cleaning"].location != NSNotFound || [strTextFieldID rangeOfString:@"Processing"].location != NSNotFound || [strTextFieldID rangeOfString:@"Testing"].location != NSNotFound) {
                            inputType = 0;
                        } else if ([strTextFieldID rangeOfString:@"Price"].location != NSNotFound || [strTextFieldID rangeOfString:@"Cost"].location != NSNotFound) {
                            inputType = 2;
                        }
                                                
                        //set up text fields and labels
                        if ([strThisSectionRowHeader isEqualToString:@"Discount"] || [strThisSectionRowHeader isEqualToString:@"Additional Cost Above Service"]) {
                            
                            if (y<2) { 
                                OAI_TextField* txtThisInput = [[OAI_TextField alloc] initWithFrame:CGRectMake(textFieldX, textFieldY, barNewThird-2.0, 30.0)];
                                txtThisInput.delegate = self;
                                txtThisInput.textFieldInputType = inputType;
                                txtThisInput.text = @"0";
                                txtThisInput.returnKeyType = UIReturnKeyDone;
                                
                                //set up text field label
                                txtThisInput.textFieldTitle = strTextFieldID;
                                
                                                                
                                //set initial 5% discount
                                if ([strThisSectionRowHeader isEqualToString:@"Discount"]) {
                                    txtThisInput.text = @"0.05";
                                }
                                
                                if ([strThisSectionTitle isEqualToString:@"Chemicals"]) {
                                    txtThisInput.tag = 800;
                                } else if (![strThisSectionTitle isEqualToString:@"Labor"] && ![strThisSectionTitle isEqualToString:@"Service"]) {
                                    txtThisInput.tag = 801;
                                } else if ([strThisSectionTitle isEqualToString:@"Labor"]) {
                                    txtThisInput.tag = 802;
                                } else if ([strThisSectionTitle isEqualToString:@"Service"]) {
                                    txtThisInput.tag = 803;
                                }
                                
                                //add it to the master text field dictionary
                                [dictTextFields setObject:txtThisInput forKey:txtThisInput.textFieldTitle];
                                
                                //ad it to the section
                                [scSections addSubview:txtThisInput];
                                
                            }
                            
                        } else if ([strTextFieldID rangeOfString:@"Cost Per Scope"].location != NSNotFound && y==2) {
                            
                            OAI_TextField* txtThisInput = [[OAI_TextField alloc] initWithFrame:CGRectMake(textFieldX, textFieldY, barNewThird-2.0, 30.0)];
                            txtThisInput.delegate = self;
                            txtThisInput.textFieldInputType = 2;
                            txtThisInput.returnKeyType = UIReturnKeyDone;
                            
                            if ([strThisSectionTitle isEqualToString:@"Labor"]) {
                                txtThisInput.tag = 802;
                            } else if ([strThisSectionTitle isEqualToString:@"Service"]) {
                                txtThisInput.tag = 804;
                            }
                            
                            //set up text field label
                            txtThisInput.textFieldTitle = strTextFieldID;
                            
                            //add it to the master text field dictionary
                            [dictTextFields setObject:txtThisInput forKey:txtThisInput.textFieldTitle];
                            
                            //ad it to the section
                            [scSections addSubview:txtThisInput];
                            
                        } else {
                            
                            OAI_Label* lblThisCellValue = [[OAI_Label alloc] initWithFrame:CGRectMake(textFieldX, textFieldY, barNewThird-2.0, 30.0)];
                            lblThisCellValue.textColor = [colorManager setColor:66.0 :66.0 :66.0];
                            lblThisCellValue.font = [UIFont fontWithName:@"Helvetica" size:20.0];
                            lblThisCellValue.backgroundColor = [UIColor clearColor];
                            lblThisCellValue.myLabelID = strTextFieldID;
                            
                            lblThisCellValue.textFieldInputType = inputType;
                            
                            //add it to the master text field dictionary
                            [dictTextFields setObject:lblThisCellValue forKey:strTextFieldID];
                            
                            //ad it to the section
                            [scSections addSubview:lblThisCellValue];
                            
                        }
                        
                        //increment x
                        textFieldX = textFieldX + barNewThird;
                        
                    }
                    
                    //reset textfieldX
                    textFieldX = labelX;
                    
                    //increment y
                    rowY = rowY + thisSectionSize.height + 10;
                    
                    //increment section height
                    sectionH = sectionH + thisSectionSize.height;
                    
                }
                
                //increment y
                sectionY = lblSectionRowHeader.frame.origin.y + lblSectionRowHeader.frame.size.height + 20.0;
                
                //increment scrollH
                scrollH = scrollH + sectionH + 80;
                
                sectionH = 0.0;
            }
            
            float labelY = sectionY;
            
            //add disclaimer
            CGSize disclaimerSize = [stringManager.strDisclaimer sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12.0] constrainedToSize:CGSizeMake(scNav.frame.size.width-30.0, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel* lblDisclaimer = [[UILabel alloc] initWithFrame:CGRectMake(sectionX+20.0, labelY, disclaimerSize.width, disclaimerSize.height)];
            lblDisclaimer.text = stringManager.strDisclaimer;
            lblDisclaimer.textColor = [colorManager setColor:66.0 :66.0 :66.0];
            lblDisclaimer.font = [UIFont fontWithName:@"Helvetica" size: 12.0];
            lblDisclaimer.backgroundColor = [UIColor clearColor];
            lblDisclaimer.numberOfLines = 0;
            lblDisclaimer.lineBreakMode = NSLineBreakByWordWrapping;
            
            scrollH = scrollH + disclaimerSize.height;
            
            //set the contentSize of the sectionScroll
            [scSections setContentSize:CGSizeMake(vTableSection.frame.size.width, scrollH)];
            
            [scNav addSubview:vTableSection];
            [scSections addSubview:lblDisclaimer];
            
            
        } else if (i==1) {
            
            arrResultHeaders = [[NSMutableArray alloc] init];
            arrResultsRowHeaderLabels = [[NSMutableArray alloc] init];
            arrResultsRowHeaderChecks = [[NSMutableArray alloc] init];
            
            //results page
            UIView* vResults = [[UIView alloc] initWithFrame:CGRectMake(772.0, 0.0, 768.0, 1004.0)];
            
            //header area
            UIView* vResultsHeader = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 100.0)];
            vResultsHeader.backgroundColor = clrDarkGrey;
            vResultsHeader.layer.shadowColor = [UIColor blackColor].CGColor;
            vResultsHeader.layer.shadowOffset = CGSizeMake(0, 2);
            vResultsHeader.layer.shadowOpacity = .75;
            
            NSString* strResultsTitle = @"Operational Cost Projections With the Olympus OER-Pro";
            CGSize resultsTitleSize = [strResultsTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            
            UILabel* lblResultsTitle = [[UILabel alloc] initWithFrame:CGRectMake((vResultsHeader.frame.size.width/2)-(resultsTitleSize.width/2), 20.0, resultsTitleSize.width, resultsTitleSize.height)];
            lblResultsTitle.text = strResultsTitle;
            lblResultsTitle.textColor = clrOlympusYellow;
            lblResultsTitle.textAlignment = NSTextAlignmentCenter;
            lblResultsTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            lblResultsTitle.backgroundColor = [UIColor clearColor];
            [vResultsHeader addSubview:lblResultsTitle];
            
            [vResults addSubview:vResultsHeader];
            
            UIButton* btnCalculations = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnCalculations setFrame:CGRectMake(lblResultsTitle.frame.origin.x, lblResultsTitle.frame.origin.y + lblResultsTitle.frame.size.height+20.0, 200.0, 20.0)];
            btnCalculations.layer.cornerRadius = 4.0f;
            [btnCalculations setTitle:@"Show Calculations" forState:UIControlStateNormal];
            btnCalculations.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btnCalculations setTitleColor:[colorManager setColor:8.0 :16.0 :123.0] forState:UIControlStateNormal];
            btnCalculations.backgroundColor = [UIColor whiteColor];
            btnCalculations.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
            [btnCalculations addTarget:self action:@selector(showCalculations:) forControlEvents:UIControlEventTouchUpInside];
            [vResultsHeader addSubview:btnCalculations];
            
            //add a scroll view
            UIScrollView* scResults = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, vResultsHeader.frame.origin.y + vResultsHeader.frame.size.height + 3.0, 768.0, 1004.0)];
            scResults.showsVerticalScrollIndicator = YES;
            
            //add the results table data
            OAI_TextField* txtProcedureCount = [dictTextFields objectForKey:@"Procedure Count"];
            NSString* strProcedureCount = txtProcedureCount.text;
            NSString* strAnnualVol = [NSString stringWithFormat:@"Annual Volume: %@", strProcedureCount];
            CGSize strAnnualSize = [strAnnualVol sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
                        
            UILabel* lblAnnualVol = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 10.0, strAnnualSize.width, strAnnualSize.height)];
            lblAnnualVol.text = strAnnualVol;
            lblAnnualVol.textColor = clrDarkGrey;
            lblAnnualVol.textAlignment = NSTextAlignmentRight;
            lblAnnualVol.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            lblAnnualVol.backgroundColor = [UIColor clearColor];
            [scResults addSubview:lblAnnualVol];
            
            //email button
            UIButton* btnEmail = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnEmail setImage:[UIImage imageNamed:@"btnEmail.png"] forState:UIControlStateNormal];
            [btnEmail setFrame:CGRectMake(self.view.frame.size.width-164.0, lblAnnualVol.frame.origin.y, 144.0, 71.0)];
            [btnEmail addTarget:self action:@selector(toggleEmailSetup:) forControlEvents:UIControlEventTouchUpInside];
            [scResults addSubview:btnEmail];
            
            //set up the headers
            arrResultsTableHeaders = [[NSArray alloc] initWithObjects:@"Operational Cost", @"Olympus OER-Pro with ALDAHOL 1.8", @"Olympus OER-Pro with Acecide-C", @"Competitor", nil];
            
            arrResultsRowHeaders = [[NSArray alloc] initWithObjects:@"Cost of Service Per Scope", @"Cost of Chemical Per Scope", @"Cost of Detergent Per Scope", @"Cost of Test Strips Per Scope", @"Cost of Filters Per Scope", @"Cost of Labor Per Scope", @"Total Cost Per Scope", nil];
            
            //get the space we have to work with
            
            float availableSpace = vResults.frame.size.width - 80.0;
            float thirdOfSpace = availableSpace/3;
            float remainingSpace = thirdOfSpace*2;
            float tableCellWidth = remainingSpace/3;
            UIFont* tableHeaderFont = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            UIFont* tableCellFont = [UIFont fontWithName:@"Helvetica" size:14];
            
            float cellW = 0.0;
            float cellX = 60.0;
            float cellY = 100.0;
            for(int i=0; i<arrResultsTableHeaders.count; i++) {
                
                if (i==0) {
                    cellW = thirdOfSpace-20.0;
                } else {
                    cellW = tableCellWidth;
                }
                
                //get header
                NSString* strThisHeader = [arrResultsTableHeaders objectAtIndex:i];
                                
                OAI_Label* lblResultsHeader = [[OAI_Label alloc] init];
                [lblResultsHeader setFrame:CGRectMake(cellX, btnEmail.frame.origin.y + btnEmail.frame.size.height + 5.0, cellW, 45.0)];
                
                lblResultsHeader.text = strThisHeader;
                lblResultsHeader.textColor = [UIColor whiteColor];
                lblResultsHeader.font = tableHeaderFont;
                lblResultsHeader.numberOfLines = 0;
                lblResultsHeader.lineBreakMode = NSLineBreakByWordWrapping;
                lblResultsHeader.textAlignment = NSTextAlignmentCenter;
                lblResultsHeader.layer.borderWidth = 1.0;
                lblResultsHeader.layer.borderColor = [UIColor whiteColor].CGColor;
                lblResultsHeader.backgroundColor = [colorManager setColor:8.0 :16.0 :123.0];
                
                if (i==arrResultsTableHeaders.count-1) {
                    lblResultsHeader.tag = 100;
                }
                
                [arrResultHeaders addObject:lblResultsHeader];
                [scResults addSubview:lblResultsHeader];
                
                cellX = lblResultsHeader.frame.origin.x + lblResultsHeader.frame.size.width;
                cellY = lblResultsHeader.frame.origin.y + lblResultsHeader.frame.size.height;
                
            }
            
            //fill in the cell data
            cellX = 60.0;
            cellW = 0.0;
            for(int i=0; i<arrResultsRowHeaders.count; i++) {
                
                //alternate colors
                UIColor* clrThisCell;
                if(i%2) {
                    clrThisCell = [colorManager setColor:253.0 :236.0 :190.0];
                } else {
                    clrThisCell = [colorManager setColor:230.0:230.0:230.0];
                }
                
                //add the row header
                NSString* strRowHeader = [arrResultsRowHeaders objectAtIndex:i];
                
                //add the checkbox
                if(i<(arrResultsRowHeaders.count-1)) {
                    OAI_CheckBox* thisCheckbox = [[OAI_CheckBox alloc] initWithFrame:CGRectMake(30.0, cellY, 30.0, 30.0)];
                    thisCheckbox.isChecked = YES;
                    thisCheckbox.strMyOperCostType = strRowHeader;
                    [scResults addSubview:thisCheckbox];
                    [arrResultsRowHeaderChecks addObject:thisCheckbox];
                }
                
                //add label
                cellW = thirdOfSpace-20.0;
                OAI_Label* lblRowHeader = [[OAI_Label alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, 40.0)];
                lblRowHeader.text = strRowHeader;
                lblRowHeader.textColor = clrDarkGrey;
                lblRowHeader.font = tableCellFont;
                lblRowHeader.backgroundColor = clrThisCell;
                lblRowHeader.layer.borderWidth = 1.0;
                lblRowHeader.layer.borderColor = [UIColor whiteColor].CGColor;
                
                //add label to label dictionary
                [arrResultsRowHeaderLabels addObject:lblRowHeader];
                
                [scResults addSubview:lblRowHeader];
                
                //set up the labels - in the showComparisons method we will populate them
                for(int x=0; x<3; x++) {
                    
                    //increment x
                    if (x==0) {
                        cellX = cellX + lblRowHeader.frame.size.width;
                    } else {
                        cellX = cellX + tableCellWidth;
                    }
                    
                    //change w
                    cellW = tableCellWidth;
                    
                    OAI_Label* lblThisLabel = [[OAI_Label alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, 40.0)];
                    
                    lblThisLabel.textColor = clrDarkGrey;
                    lblThisLabel.font = tableCellFont;
                    lblThisLabel.backgroundColor = clrThisCell;
                    lblThisLabel.layer.borderWidth = 1.0;
                    lblThisLabel.layer.borderColor = [UIColor whiteColor].CGColor;
                    
                    NSString* strSuffix;
                    if (x==0) {
                        strSuffix = @"ALDAHOL";
                    } else if (x==1) {
                        strSuffix = @"AcecideC";
                    } else if (x==2) {
                        strSuffix = @"Competition";
                    }
                    
                    //add them to the dictionary
                    if([strRowHeader rangeOfString:@"Service"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Service Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Chemical"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Chemical Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Detergent"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Detergent Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Test Strips"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Test Strips Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Filters"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Filters Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Labor"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Labor Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    } else if ([strRowHeader rangeOfString:@"Total"].location !=NSNotFound) {
                        NSString* strThisKey = [NSString stringWithFormat:@"Total Cost Per Scope %@", strSuffix];
                        [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                    }
                    
                    [scResults addSubview:lblThisLabel];
                    
                }
                
                //increment y
                cellY = cellY + 40.0;
                
                //reset x
                cellX = 60.0;
            }
            
            //add notes
            NSString* strCostNotes = @"Items marked in red will not appear in email message!\n\nThe additional cost of the OER-Pro with Acecide may be offset by the time and safety improvements noted in this document.\n\nThe OER-Pro is designed to reprocess two endoscopes per cycle. The \"cost per scope\" reflects the cost for reprocessing one scope when scopes are reprocessed per cycle.\n\nThe number of cycles and the cost of filters per case varies depending on water quality and is difficult to project. Filter costs for an Olympus-purchased prefiltration system are included in this tool. Additionally, other factors such as test strip interpretation, selected chemistry and other environmental factors great influence the number of cycles before a change is required. The projected numbers provided in this calculator are only an estimate. Olympus suggests meeting with your Clinical Bioengineering Department to address local issues related to this expense.";
            
            UILabel* lblCostNotes = [[UILabel alloc] initWithFrame:CGRectMake(40.0, cellY, self.view.frame.size.width-80.0, 300.0)];
            lblCostNotes.text = strCostNotes;
            lblCostNotes.textColor = [colorManager setColor:66.0 :66.0 :66.0];
            lblCostNotes.font = [UIFont fontWithName:@"Helvetica" size:14.0];
            lblCostNotes.backgroundColor = [UIColor clearColor];
            lblCostNotes.numberOfLines = 0;
            lblCostNotes.lineBreakMode = NSLineBreakByWordWrapping;
            [scResults addSubview:lblCostNotes];
            
            //build the time comparison table
            UILabel* lblTimeTable = [[UILabel alloc] initWithFrame:CGRectMake(40.0, lblCostNotes.frame.origin.y + lblCostNotes.frame.size.height, self.view.frame.size.width, 40.0)];
            lblTimeTable.text = @"Time Savings:";
            lblTimeTable.textColor = clrDarkGrey;
            lblTimeTable.textAlignment = NSTextAlignmentLeft;
            lblTimeTable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            lblTimeTable.backgroundColor = [UIColor clearColor];
            [scResults addSubview:lblTimeTable];
            
            cellW = 0.0;
            cellX = 40.0;
            cellY = lblTimeTable.frame.origin.y + lblTimeTable.frame.size.height + 10.0;
            
            UILabel* lblTimeSavingsHeader;
            
            for(int i=0; i<arrTypes.count+1; i++) {
                
                //add row header space holder
                NSString* strHeader;
                if (i==0) {
                    strHeader = @"";
                    cellW = thirdOfSpace;
                } else if (i == arrTypes.count) {
                    if(strSelectedCompetitor != nil) {
                        strHeader = strSelectedCompetitor;
                    } else {
                        strHeader = @"Competitor";
                    }
                    
                } else {
                    strHeader = [arrTypes objectAtIndex:i-1];
                    cellW = tableCellWidth;
                }
                
                lblTimeSavingsHeader = [[UILabel alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, 45.0)];
                lblTimeSavingsHeader.text = strHeader;
                lblTimeSavingsHeader.textColor = [UIColor whiteColor];
                lblTimeSavingsHeader.font = tableHeaderFont;
                lblTimeSavingsHeader.numberOfLines = 0;
                lblTimeSavingsHeader.lineBreakMode = NSLineBreakByWordWrapping;
                lblTimeSavingsHeader.backgroundColor = [colorManager setColor:8.0 :16.0 :123.0];
                lblTimeSavingsHeader.textAlignment = NSTextAlignmentCenter;
                lblTimeSavingsHeader.layer.borderWidth = 1.0;
                lblTimeSavingsHeader.layer.borderColor = [UIColor whiteColor].CGColor;
                
                [scResults addSubview:lblTimeSavingsHeader];
                
                cellX = lblTimeSavingsHeader.frame.origin.x + lblTimeSavingsHeader.frame.size.width;
                
                [dictResultCells setObject:lblTimeSavingsHeader forKey:strHeader];
                
            }
            
            //set up the row headers
            arrTimeSavingsRowHeaders = [[NSArray alloc] initWithObjects:@"Pre-Cleaning", @"Leakage Testing", @"Manual Cleaning", @"AER Processing", @"Post-AER Processing", @"Total Time Per Cycle (Minutes)", nil];
            
            float rowX = 40.0;
            float rowY = lblTimeSavingsHeader.frame.origin.y + lblTimeSavingsHeader.frame.size.height;
            float rowW = thirdOfSpace;
            float rowH = 40.0;
            
            for(int i=0; i<arrTimeSavingsRowHeaders.count; i++) {
                                
                //alternate colors
                UIColor* clrThisCell;
                if(i%2) {
                    clrThisCell = [colorManager setColor:253.0 :236.0 :190.0];
                } else {
                    clrThisCell = [colorManager setColor:230.0:230.0:230.0];
                }
                
                NSString* strTimeSavngsRowHeader = [arrTimeSavingsRowHeaders objectAtIndex:i];
                
                OAI_Label* lblTimeSavingsRowHeader = [[OAI_Label alloc] initWithFrame:CGRectMake(rowX, rowY, rowW, rowH)];
                lblTimeSavingsRowHeader.text = strTimeSavngsRowHeader;
                lblTimeSavingsRowHeader.textColor = [colorManager setColor:51.0 :51.0 :51.0];
                lblTimeSavingsRowHeader.font = tableCellFont;
                lblTimeSavingsRowHeader.backgroundColor = clrThisCell;
                lblTimeSavingsRowHeader.layer.borderWidth = 1.0;
                lblTimeSavingsRowHeader.layer.borderColor = [UIColor whiteColor].CGColor;
                [scResults addSubview:lblTimeSavingsRowHeader];
                
                
                NSString* strSuffix; 
                for(int x=0; x<3; x++) {
                    
                    //change w
                    rowW = tableCellWidth;
                 
                    if (x==0) {
                        strSuffix = @"_ALDAHOL";
                    } else if (x==1) {
                        strSuffix = @"_AcecideC";
                    } else if (x==2) {
                        strSuffix = @"_Competition";
                    }
                    
                    //increment x
                    if (x==0) {
                        rowX = rowX + lblTimeSavingsRowHeader.frame.size.width;
                    } else {
                        rowX = rowX + tableCellWidth;
                    }
                                        
                    OAI_Label* lblThisLabel = [[OAI_Label alloc] initWithFrame:CGRectMake(rowX, rowY, rowW, 40.0)];
                    
                    lblThisLabel.textColor = clrDarkGrey;
                    lblThisLabel.font = tableCellFont;
                    lblThisLabel.backgroundColor = clrThisCell;
                    lblThisLabel.layer.borderWidth = 1.0;
                    lblThisLabel.layer.borderColor = [UIColor whiteColor].CGColor;
                    
                    
                    [scResults addSubview:lblThisLabel];
                    
                    //add the label to the dictResultsCells dictionary
                    NSString* strThisKey = [NSString stringWithFormat:@"%@%@", strTimeSavngsRowHeader, strSuffix];
                    
                    lblThisLabel.myLabelID = strThisKey;
                    
                    [dictResultCells setObject:lblThisLabel forKey:strThisKey];
                                        
                }
                
                //increment y
                rowY = rowY + 40.0;
                
                //reset rowX
                rowX = 40.0;
                
                rowW = thirdOfSpace;
                
            }
            
            OAI_Label* lblTimeSavingNotes = [[OAI_Label alloc] initWithFrame:CGRectMake(40.0, rowY-40.0, self.view.frame.size.width-40.0, 200.0)];
            lblTimeSavingNotes.text = @"Our intimate knowledge of endoscope design allows us to use proprietary technologies to provide you with an enhanced reprocessing experience. As part of that experience, the OER-Pro eliminates 7 of the 11 recommended manual cleaning steps.";
            lblTimeSavingNotes.textColor = [colorManager setColor:51.0 :51.0 :51.0];
            lblTimeSavingNotes.font = tableCellFont;
            lblTimeSavingNotes.backgroundColor = [UIColor clearColor];
            lblTimeSavingNotes.numberOfLines = 0;
            lblTimeSavingNotes.lineBreakMode = NSLineBreakByWordWrapping;
            [scResults addSubview:lblTimeSavingNotes];
            
            //add time savings notes
            OAI_Label* lblAcedideCTitle = [[OAI_Label alloc] initWithFrame:CGRectMake(40.0, lblTimeSavingNotes.frame.origin.y+lblTimeSavingNotes.frame.size.height-40.0, 200.0, 30.0)];
            lblAcedideCTitle.text = @"Acecide-C:";
            lblAcedideCTitle.textColor = [colorManager setColor:51.0 :51.0 :51.0];
            lblAcedideCTitle.font = tableHeaderFont;
            lblAcedideCTitle.backgroundColor = [UIColor clearColor];
            [scResults addSubview:lblAcedideCTitle];
            
            //add time savings notes
            OAI_Label* lblAcedideCNotes = [[OAI_Label alloc] initWithFrame:CGRectMake(40.0, lblAcedideCTitle.frame.origin.y + lblAcedideCTitle.frame.size.height-30.0, self.view.frame.size.width, 120.0)];
            lblAcedideCNotes.text = @"Conservatively Acecide-C saving estimate vs. ALDAHOL 1.8 is: 9 minutes\nAnnual staff time savings is estimated to be at least: 300 hours\nAt $15 per hour, this annual savings totals: $4500";
            lblAcedideCNotes.textColor = [colorManager setColor:51.0 :51.0 :51.0];
            lblAcedideCNotes.font = tableCellFont;
            lblAcedideCNotes.numberOfLines = 0;
            lblAcedideCNotes.lineBreakMode = NSLineBreakByWordWrapping;
            lblAcedideCNotes.backgroundColor = [UIColor clearColor];
            [scResults addSubview:lblAcedideCNotes];
            
            //set the scResults content size
            [scResults setContentSize:CGSizeMake(vResults.frame.size.width, 1500.0)];
            
            [vResults addSubview:scResults];
            [scNav addSubview:vResults];
            
        } else if (i==2) {
            
        }
    }
    
    /***********EMAIL**************/
    
    vEmailManager = [[OAI_EmailSetup alloc] initWithFrame:CGRectMake(0.0, 0.0-400.0, self.view.frame.size.width, 400.0)];
    [vMainView addSubview:vEmailManager];
    
    arrEmailCheckboxes = vEmailManager.arrMyCheckboxes;
    
    
    //do initial calculations
    [self calculate:@"All":YES];
    
    /**********COMP CHOICES VIEW**********/
    
    //get the splits
    float barThird = scNav.frame.size.width/3;
    float barTwoThirds = barThird*2;
    float barNewThird = barTwoThirds/3;
    float maxRowHeight = 0.0;
    compViewHeight = 0.0;
    
    //get the needed height of the view and max row height
    for(int i=0; i<arrCompetitorNames.count; i++) {
        
        NSString* strThisCompetitor = [arrCompetitorNames objectAtIndex:i];
        CGSize thisCompetitorSize = [strThisCompetitor sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16.0] constrainedToSize:CGSizeMake(barNewThird+2.0, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
        
        compViewHeight = compViewHeight + thisCompetitorSize.height;
        
        if (thisCompetitorSize.height > maxRowHeight) {
            maxRowHeight = thisCompetitorSize.height;
        }
        
    }
    
    vCompChoices = [[UIView alloc] initWithFrame:CGRectMake(597.333, 370, barNewThird+8, 0.0)];
    
    vCompChoices.backgroundColor = [UIColor whiteColor];
    
    tblCompetitors = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, vCompChoices.frame.size.width, vCompChoices.frame.size.height)];
    tblCompetitors.delegate = self;
    tblCompetitors.dataSource = self;
    tblCompetitors.rowHeight = 60.0;
    tblCompetitors.userInteractionEnabled = YES;
    [vCompChoices addSubview:tblCompetitors];
    
    
    [vMainView addSubview:vCompChoices];
    
    /*************************************
     SPLASH SCREEN
     *************************************/
    
    //check to see if we need to display the splash screen
    BOOL needsSplash = YES;
    
    if (needsSplash) {
        CGRect myBounds = self.view.bounds;
        appSplashScreen = [[OAI_SplashScreen alloc] initWithFrame:CGRectMake(myBounds.origin.x, myBounds.origin.y, myBounds.size.width, myBounds.size.height)];
        [vMainView addSubview:appSplashScreen];
        [appSplashScreen runSplashScreenAnimation];
    }
    
    /*******************************
     USER ACCOUNT INFO
     **********************************/
    
    vAccount = [[UIView alloc] initWithFrame:CGRectMake(100.0, -350.0, 300.0, 350.0)];
    vAccount.backgroundColor = [UIColor whiteColor];
    vAccount.layer.shadowColor = [UIColor blackColor].CGColor;
    vAccount.layer.shadowRadius = 5.0;
    vAccount.layer.shadowOpacity = 0.75;
    
    
    //title and instructions
    NSString* strAccountInfo = @"Account Info";
    CGSize accountInfoSize = [strAccountInfo sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
    UILabel* lblAcountInfo = [[UILabel alloc] initWithFrame:CGRectMake((vAccount.frame.size.width/2)-(accountInfoSize.width/2), 20.0, accountInfoSize.width, accountInfoSize.height)];
    lblAcountInfo.text = strAccountInfo;
    lblAcountInfo.textColor = [colorManager setColor:66.0 :66.0 :66.0];
    lblAcountInfo.backgroundColor = [UIColor clearColor];
    lblAcountInfo.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    [vAccount addSubview:lblAcountInfo];
    
    NSString* strAccountInst = @"Enter your account info below. This will be stored and used when emailing results.";
    CGSize accountInstSize = [strAccountInst sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13.0] constrainedToSize:CGSizeMake(vAccount.frame.size.width-40.0, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel* lblAcountInst = [[UILabel alloc] initWithFrame:CGRectMake((vAccount.frame.size.width/2)-(accountInstSize.width/2), lblAcountInfo.frame.origin.y + lblAcountInfo.frame.size.height + 5.0, accountInstSize.width, accountInstSize.height)];
    lblAcountInst.text = strAccountInst;
    lblAcountInst.textColor = [colorManager setColor:66.0 :66.0 :66.0];
    lblAcountInst.backgroundColor = [UIColor clearColor];
    lblAcountInst.numberOfLines = 0;
    lblAcountInst.lineBreakMode = NSLineBreakByWordWrapping;
    lblAcountInst.font = [UIFont fontWithName:@"Helvetica" size:13.0];
    [vAccount addSubview:lblAcountInst];
    
    
    //form elements
    OAI_TextField* txtUserName = [[OAI_TextField alloc] initWithFrame:CGRectMake(20.0, lblAcountInst.frame.origin.y + lblAcountInst.frame.size.height + 35.0, vAccount.frame.size.width-40.0, 30.0)];
    txtUserName.placeholder = @"Name";
    txtUserName.font = [UIFont fontWithName:@"Helvetica" size: 16.0];
    txtUserName.borderStyle = UITextBorderStyleRoundedRect;
    txtUserName.backgroundColor = [UIColor whiteColor];
    txtUserName.delegate = self;
    txtUserName.tag = 601;
    [vAccount addSubview:txtUserName];
    
    OAI_TextField* txtUserTitle = [[OAI_TextField alloc] initWithFrame:CGRectMake(20.0, txtUserName.frame.origin.y + txtUserName.frame.size.height + 15.0, vAccount.frame.size.width-40.0, 30.0)];
    txtUserTitle.placeholder = @"Title";
    txtUserTitle.font = [UIFont fontWithName:@"Helvetica" size: 16.0];
    txtUserTitle.borderStyle = UITextBorderStyleRoundedRect;
    txtUserTitle.backgroundColor = [UIColor whiteColor];
    txtUserTitle.delegate = self;
    txtUserTitle.tag = 602;
    [vAccount addSubview:txtUserTitle];
    
    OAI_TextField* txtUserEmail = [[OAI_TextField alloc] initWithFrame:CGRectMake(20.0, txtUserTitle.frame.origin.y + txtUserTitle.frame.size.height + 10.0, vAccount.frame.size.width-40.0, 30.0)];
    txtUserEmail.placeholder = @"Olympus Email Address";
    txtUserEmail.font = [UIFont fontWithName:@"Helvetica" size: 16.0];
    txtUserEmail.borderStyle = UITextBorderStyleRoundedRect;
    txtUserEmail.backgroundColor = [UIColor whiteColor];
    txtUserEmail.delegate = self;
    txtUserEmail.tag = 603;
    [vAccount addSubview:txtUserEmail];
    
    OAI_TextField* txtUserPhone = [[OAI_TextField alloc] initWithFrame:CGRectMake(20.0, txtUserEmail.frame.origin.y + txtUserEmail.frame.size.height + 10.0, vAccount.frame.size.width-40.0, 30.0)];
    txtUserPhone.placeholder = @"Phone Number";
    txtUserPhone.font = [UIFont fontWithName:@"Helvetica" size: 16.0];
    txtUserPhone.borderStyle = UITextBorderStyleRoundedRect;
    txtUserPhone.backgroundColor = [UIColor whiteColor];
    txtUserPhone.delegate = self;
    txtUserPhone.tag = 604;
    [vAccount addSubview:txtUserPhone];
    
    //add the toggle account data button
    UIImage* imgCloseX = [UIImage imageNamed:@"btnCloseX.png"];
    UIButton* btnCloseX = [[UIButton alloc] initWithFrame:CGRectMake(vAccount.frame.size.width-(imgCloseX.size.width+10.0), vAccount.frame.size.height-(imgCloseX.size.height+10.0), imgCloseX.size.width, imgCloseX.size.height)];
    [btnCloseX setImage:imgCloseX forState:UIControlStateNormal];
    [btnCloseX addTarget:self action:@selector(toggleAccount:) forControlEvents:UIControlEventTouchUpInside];
    [btnCloseX setBackgroundColor:[UIColor clearColor]];
    [vAccount addSubview:btnCloseX];
    
    [vMainView addSubview:vAccount];
    [vMainView bringSubviewToFront:titleBarManager];
    
    [self.view addSubview:vMainView];
    
}

- (void) showCompetitors : (UITapGestureRecognizer*) tgrMyTGR {
    
    CGRect compFrame = vCompChoices.frame;
    
    if (compFrame.size.height == 0) { 
        compFrame.size.height = compViewHeight;
    } else {
        compFrame.size.height = 0.0;
    }
    
    //resize the table
    CGRect tableFrame = tblCompetitors.frame;
    tableFrame.size.height = compFrame.size.height;
    tblCompetitors.frame = tableFrame;
    
    //toggle the view
    [UIView animateWithDuration:0.4
     
            animations:^(void) {
                vCompChoices.frame = compFrame;
            }
     
             completion:^(BOOL finished) {
                 nil;
             }
     ];
}

- (void) addCompetitorTimes {
    
    NSString* strAERProcessng;
    NSString* strLeakageTesting;
    NSString* strManualCleaning;
    NSString* strPostAERPRocessing;
    NSString* strPreCleaning;
    NSString* strCompName;
    
    //get the values
    for(NSString* strThisKey in dictCompetitors) {
        
        if([strThisKey isEqualToString:strSelectedCompetitor]) {
            NSDictionary* dictCompData = [dictCompetitors objectForKey:strThisKey];
            strCompName = strThisKey;
            strAERProcessng = [dictCompData objectForKey:@"AER Processing"];
            strLeakageTesting = [dictCompData objectForKey:@"Leakage Test"];
            strManualCleaning = [dictCompData objectForKey:@"Manaual Cleaning"];
            strPostAERPRocessing = [dictCompData objectForKey:@"Post AER Processing"];
            strPreCleaning = [dictCompData objectForKey:@"Pre-Cleaning"];
            break;
        }
    }
    
    //display the values
    for(NSString* strThisKey in dictTextFields) {
        
        if ([strThisKey isEqualToString:@"Operation Time_AER Processing_Competition"]) {
            OAI_TextField* txtThisField = [dictTextFields objectForKey:strThisKey];
            txtThisField.text = strAERProcessng;
        } else if ([strThisKey isEqualToString:@"Operation Time_Leakage Testing_Competition"]) {
            OAI_TextField* txtThisField = [dictTextFields objectForKey:strThisKey];
            txtThisField.text = strLeakageTesting;
        } else if ([strThisKey isEqualToString:@"Operation Time_Manual Cleaning_Competition"]) {
            OAI_TextField* txtThisField = [dictTextFields objectForKey:strThisKey];
            txtThisField.text = strManualCleaning;
        } else if ([strThisKey isEqualToString:@"Operation Time_Post AER Processing_Competition"]) {
            OAI_TextField* txtThisField = [dictTextFields objectForKey:strThisKey];
            txtThisField.text = strPostAERPRocessing;
        } else if ([strThisKey isEqualToString:@"Operation Time_Pre-Cleaning_Competition"]) {
            OAI_TextField* txtThisField = [dictTextFields objectForKey:strThisKey];
            txtThisField.text = strPreCleaning;
        }
    }
    
    //change the cell label text
    NSArray* arrNavSubviews = scNav.subviews;
    UIView* vScrollPage1 = [arrNavSubviews objectAtIndex:1];
    NSArray* arrScrollPage1Subs = vScrollPage1.subviews;
    OAI_Label* lblCompetitors = [arrScrollPage1Subs objectAtIndex:3];
    lblCompetitors.text = strCompName;
    
    [self calculateWithResults:nil];
    
}

- (void) resetValues {
    
    if (dictInitialValues.count > 0) {
        
        //reset the selected competitor to nil
        strSelectedCompetitor = nil;
        
        //reset the title of the competition in the comparison table
        
        //reset select a competitor label
        NSArray* arrVCSubviews = self.view.subviews;
        
        for(int i=0; i<arrVCSubviews.count; i++) {
            if ([[arrVCSubviews objectAtIndex:i] isMemberOfClass:[UIScrollView class]]) {
                UIScrollView* svThisView = [arrVCSubviews objectAtIndex:i];
                NSArray* arrScrollViewSubs = svThisView.subviews;
                UIView* vThisView = [arrScrollViewSubs objectAtIndex:1];
                NSArray* arrThisViewSubs = vThisView.subviews;
                for(int x=0; x<arrThisViewSubs.count; x++) {
                    
                    if ([[arrThisViewSubs objectAtIndex:x] isMemberOfClass:[OAI_Label class]]) {
                        OAI_Label* lblThisLabel = [arrThisViewSubs objectAtIndex:x];
                        if(lblThisLabel.tag == 500) {
                            lblThisLabel.text = @"Select A \nCompetitor";
                        }
                    }
                }
            }
        }
        
        for(NSString* strThisKey in dictTextFields) {
            
            //set some ivars
            OAI_TextField* thisTextField;
            OAI_Label* thisLabel;
            NSString* thisElementTitle;
            BOOL isTextField = NO;
            BOOL isLabel = NO;
            
            //determine if we are working with a textfield or label, get its id
            if ([[dictTextFields objectForKey:strThisKey] isMemberOfClass:[OAI_TextField class]]) {
                
                thisTextField = [dictTextFields objectForKey:strThisKey];
                isTextField = YES;
                thisElementTitle = thisTextField.textFieldTitle;
                
            } else if ([[dictTextFields objectForKey:strThisKey] isMemberOfClass:[OAI_Label class]]) {
                
                thisLabel = [dictTextFields objectForKey:strThisKey];
                isLabel = YES;
                thisElementTitle = thisLabel.myLabelID;
            }
            
            //loop through the initial values
            for(NSString* strThisValueKey in dictInitialValues) {
                
                //look for match
                if ([thisElementTitle isEqualToString:strThisValueKey]) {
                    
                    //give element value
                    if (isTextField) {
                        thisTextField.text = [dictInitialValues objectForKey:strThisValueKey];
                    }
                    
                    if (isLabel) {
                        thisLabel.text = [dictInitialValues objectForKey:strThisValueKey];
                    }
                }
            }
            
        }
        
        [self calculate:@"ALL":NO];
    }
}

#pragma mark - Notification Center
- (void) receiveNotification:(NSNotification* ) notification {
    
    if ([[notification name] isEqualToString:@"theMessenger"]) {
        
        //get the event
        NSString* strAction = [[notification userInfo] objectForKey:@"Action"];
        
        //check which action
        if ([strAction isEqualToString:@"Show Results"]) {
            
            //get our results dictionary
            dictResults = [[notification userInfo] objectForKey:@"Results"];
            
            [self showResults:dictResults];
            
        } else if ([strAction isEqualToString:@"Send Email"]) {
            
            strFacilityName = [[notification userInfo] objectForKey:@"Facility Name"];
            [self sendEmail];
            
        } else if ([strAction isEqualToString:@"Show Account"]) {
            [self toggleAccount:nil];
            
        } else if ([strAction isEqualToString:@"Reset All"]) {
            [self resetValues];
            
        } else if ([strAction isEqualToString:@"Checkbox Toggle"]) {
            
            NSString* strThisRowHeader = [[notification userInfo] objectForKey:@"Row Header"];
            OAI_CheckBox* thisCheckbox = [[notification userInfo] objectForKey:@"Checkbox"];
            
            [self resetComparisonDisplay:strThisRowHeader:thisCheckbox];
        }
    }
}

#pragma mark - Account Management

- (void) toggleAccount : (UIButton*) btnAccount {
    
    [self.view endEditing:YES];
    
    BOOL isShowing = NO;
    
    //reset the frame
    CGRect vAccountFrame = vAccount.frame;
    if (vAccountFrame.origin.y < 0) {
        vAccountFrame.origin.y = 39.0;
        isShowing = YES;
    } else {
        vAccountFrame.origin.y = -350.0;
        isShowing = NO;
    }
    
    //if being displayed get the stored data and display it
    if (isShowing) {
        
        NSString* strAccountPlist = @"UserAccount.plist";
        NSDictionary* dictAccountData = [fileManager readPlist:strAccountPlist];
        
        //set strings to the data
        NSString* strUserName = [dictAccountData objectForKey:@"User Name"];
        NSString* strUserTitle = [dictAccountData objectForKey:@"User Title"];
        NSString* strUserEmail = [dictAccountData objectForKey:@"User Email"];
        NSString* strUserPhone = [dictAccountData objectForKey:@"User Phone"];
        
        //get the subviews
        NSArray* vAccountSubs = vAccount.subviews;
        
        //loop
        for(int i=0; i<vAccountSubs.count; i++) {
            
            //sniff for text fields
            if ([[vAccountSubs objectAtIndex:i] isMemberOfClass:[UITextField class]]) {
                
                //cast
                UITextField* thisTextField = (UITextField*)[vAccountSubs objectAtIndex:i];
                
                //set contents of text field
                if (thisTextField.tag == 601) {
                    thisTextField.text = strUserName;
                } else if (thisTextField.tag == 602) {
                    thisTextField.text = strUserTitle;
                } else if (thisTextField.tag == 603) {
                    thisTextField.text = strUserEmail;
                } else if (thisTextField.tag == 604) {
                    thisTextField.text = strUserPhone;
                }
                
            }
        }
        
    }
    
    [self animateView:vAccount :vAccountFrame];
}

- (void) animateView : (UIView* ) thisView : (CGRect) thisFrame {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
     
         animations:^{
             thisView.frame = thisFrame;
         }

         completion:^ (BOOL finished) {
             
             if (thisView.tag == 102) {
                 
                 NSArray* thisViewSubViews = thisView.subviews;
                 
                 for(int v=0; v<thisViewSubViews.count; v++) {
                     
                     if([[thisViewSubViews objectAtIndex:v] isMemberOfClass:[UITextView class]]) {
                         
                         UITextView* thisTextView = (UITextView*)[thisViewSubViews objectAtIndex:v];
                         CGRect textViewFrame = thisTextView.frame;
                         textViewFrame.size.height = textViewFrame.size.height + 1.0;
                         thisTextView.frame = textViewFrame;
                         
                     }
                 }
                 
             }
         }
    ];
    
}

#pragma mark - Show Results

- (void) showResults : (NSDictionary*) dictTheResults {
    
    
    //loop through the results dictionary and see what comes out
    for(NSString* strThisKey in dictTheResults) {
        
        //loop through the text field dictionary and find a match
        for(NSString* strThisTextFieldKey in dictTextFields) {
            
            //find a match
            if ([strThisKey isEqualToString:strThisTextFieldKey]) {
                
                //get the text field
                if([[dictTextFields objectForKey:strThisTextFieldKey] isMemberOfClass:[OAI_TextField class]]) {
                    
                    OAI_TextField* thisTextField = [dictTextFields objectForKey:strThisTextFieldKey];
                    
                    NSString* strDisplayString;
                    //convert to currency string if needed
                    if (thisTextField.textFieldInputType == 2) {
                        
                        strDisplayString = [dictResults objectForKey:strThisKey];
                        
                        //check to see if string starts with a dollar sign
                        if([strDisplayString hasPrefix:@"$"]) {
                                
                            //strip dollar sign
                            strDisplayString = [self stripDollarSign:strDisplayString];
                            
                        }
                            
                        //convert to nsdecimal number
                        NSDecimalNumber* decThisNumber = [[NSDecimalNumber alloc] initWithString:strDisplayString];
                        
                        //convert to currency string
                        strDisplayString = [self convertToCurrencyString:decThisNumber];
                        
                    } else if (thisTextField.textFieldInputType == 0) {
                        strDisplayString = [dictTheResults objectForKey:strThisKey];
                    } else if (thisTextField.textFieldInputType == 1) {
                        strDisplayString = [dictTheResults objectForKey:strThisKey];
                    }
                    
                    //set it's text value
                    thisTextField.text = strDisplayString;
                    
                    
                } else if ([[dictTextFields objectForKey:strThisTextFieldKey] isMemberOfClass:[OAI_Label class]]) {
                    
                    OAI_Label* lblThisLabel = [dictTextFields objectForKey:strThisTextFieldKey];
                    
                    NSString* strDisplayString;
                    
                    //convert to currency string if needed
                    if (lblThisLabel.textFieldInputType == 2) {
                        
                        strDisplayString = [dictResults objectForKey:strThisKey];
                        
                        //strip dollar sign
                        strDisplayString = [self stripDollarSign:strDisplayString];
                        
                        //convert to nsdecimal number
                        NSDecimalNumber* decThisNumber = [[NSDecimalNumber alloc] initWithString:strDisplayString];
                        
                        //convert to currency string
                        strDisplayString = [self convertToCurrencyString:decThisNumber];
                        
                        
                    } else if (lblThisLabel.textFieldInputType == 0) {
                        strDisplayString = [dictResults objectForKey:strThisKey];
                    } else if (lblThisLabel.textFieldInputType == 1) {
                        strDisplayString = [dictResults objectForKey:strThisKey];
                    }
                    
                    //set it's text value
                    lblThisLabel.text = strDisplayString;
                    
                }
                
                //stop looping
                break;
            }
        }
        
    }
    
}


#pragma mark - Calculations and Conversions

- (void) calculate : (NSString*) strCalculateWhat : (BOOL) isOpening {
    
    BOOL isValid = YES;
    
    //validate the entries
    if (!isOpening) { 
        isValid = [self validateEntries:strCalculateWhat:nil];
    }
    
    if (isValid) {
        
        calculator.isOpening = isOpening;
        calculator.dictTextFields = dictTextFields;
        [calculator calculate:NO:strCalculateWhat];
        
        //if this is the first time we calculate then store the initial values
        if (isOpening) {
            dictInitialValues = calculator.dictInitialValues;
        }
    }
    
}

- (void) calculateWithResults : (UIButton*) myButton {
    
    //validate the entries
    BOOL isValid = [self validateEntries:@"ALL":nil];
    if (isValid) {
        calculator.dictTextFields = dictTextFields;
        [calculator calculate:YES:@"All"];
    }
}

- (BOOL) checkStringValue : (NSString*) stringToCheck {
    
    NSNumberFormatter* numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setAllowsFloats: YES];
    
    if ([numFormatter numberFromString: stringToCheck]) {
        return YES;
    } else {
        return NO;
    }
    
    return YES;
}

- (BOOL) validateEntries : (NSString*) validateWhat : (UITextField*) textField; {
    
    //set up error check
    BOOL isValid = YES;
    NSMutableString* errMsg = [[NSMutableString alloc] init];
    [errMsg appendString:@"There was an error with your text field entry.\n\n"];
    
    //get a text field
    OAI_TextField* thisTextField;
    
    //validate everything
    if ([validateWhat isEqualToString:@"ALL"]) {
        
        //loop through the text fields
        for(NSString* strThisKey in dictTextFields) {
            
            //get a text field
            thisTextField = [dictTextFields objectForKey:strThisKey];
            
            //make sure there is an entry
            if(thisTextField.text.length > 0 || thisTextField.text != nil) {
                //pass it to the validator
                isValid = [self validateThisEntry:thisTextField];
            }
        }
        
    } else {
        
        //get the specific text field
        thisTextField = [dictTextFields objectForKey:validateWhat];
        
        //pass it to the validator
        isValid = [self validateThisEntry:thisTextField];
    }
    
    
    if (!isValid) {
        
        [errMsg appendString:[NSString stringWithFormat:@"You must enter a number in this text field! Do not enter any symbols such as dollar or percent signs, the application will take care of that for you."]];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Text Field Entry Error"
                              message: errMsg
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:
                              nil];
        
        [alert show];
        
        if(textField) { 
            textField.text = strCurrentTextFieldValue;
        }
        
    }
    
    return isValid;
    
    
}

- (NSString*) convertToCurrencyString : (NSDecimalNumber*) numberToConvert {
    
    //convert to string
    NSString* currencyString = [NSNumberFormatter localizedStringFromNumber:numberToConvert numberStyle:NSNumberFormatterCurrencyStyle];
    
    return currencyString;
}

- (NSString*) stripDollarSign : (NSString*) stringToStrip {
    
    //check to see if the number is already formatted correctly
    NSRange dollarSignCheck = [stringToStrip rangeOfString:@"$"];
    //only strip it if it has the $
    if (dollarSignCheck.location != NSNotFound) {
        NSString* cleanedString = [stringToStrip substringWithRange:NSMakeRange(1, stringToStrip.length-1)];
        return cleanedString;
    } else {
        return stringToStrip;
    }
    
    return 0;
    
}

- (NSString*) stripDecimalPoints : (NSString*) stringToStrip {
    
    //check to see if the number is already formatted correctly
    NSRange decimalCheck = [stringToStrip rangeOfString:@"."];
    
    //only strip it if it has the decimal
    if (decimalCheck.location != NSNotFound) {
        
        NSRange endRange = [stringToStrip rangeOfString:@"."];
        NSString* cleanedString = [stringToStrip substringWithRange:NSMakeRange(0, endRange.location)];
        return cleanedString;
    }
    
    return 0;
    
}


- (BOOL) validateThisEntry : (OAI_TextField*) textField {
    
    
    //set up BOOL
    BOOL isValid = YES;
    
    if (textField) { 
    
        //get the textfield input type
        int intInputType = textField.textFieldInputType;
        
        
        
        if (intInputType == 0 || intInputType == 1) {
            
            //validate that the user entered a number
            NSString* strValue = textField.text;
            
            isValid = [self checkStringValue:strValue];
            
            
        } else {
            
            
            
        }
            
    }
    
    return isValid;
        
    
}

#pragma mark - Show Comparison and Time Savings

- (void) showComparison : (UIButton*) myButton {
    
    dictResultsData = [[NSMutableDictionary alloc] init];
    
    //NSLog(@"%@", dictResults);
    
    OAI_TextField* txtAnnualProcedures =  [dictTextFields objectForKey:@"Procedure Count"];
    [dictResultsData setObject:txtAnnualProcedures.text forKey:@"Annual Procedures"];
    
    float serviceCostALDAHOL;
    float serviceCostAcecideC;
    float serviceCompetitionCost;
    float chemicalCostALDAHOL;
    float chemicalCostAcecideC;
    float chemicalCompetitionCost;
    float detergentCostALDAHOL;
    float detergentCostAcecideC;
    float detergentCostCompetition;
    float testStripsCostALDAHOL;
    float testStripsCostAcecideC;
    float testStripsCostCompetition;
    float filtersCostALDAHOL;
    float filtersCostAcecideC;
    float filtersCostCompetition;
    float laborCostALDAHOL;
    float laborCostAcecideC;
    float laborCostCompetition;
    float lastLabelY;
    
    NSString* strALDAHOLTotalCost;
    NSString* strAcecideCTotalCost;
    NSString* strCompetitionTotalCost;
    
    UIScrollView* scResultsScrollView;
    
    OAI_Label* lblCompHeader = [arrResultHeaders objectAtIndex:3];
    if (!strSelectedCompetitor) {
        lblCompHeader.alpha = 0.0;
    } else {
        lblCompHeader.alpha = 1.0;
    }
    
    //loop through the results
    for(NSString* strThisKey in dictResults) {
        
        //get all the cost per scope from the results
        if ([strThisKey rangeOfString:@"Cost Per Scope"].location !=NSNotFound) {
            
            //look for our categories
            if ([strThisKey rangeOfString:@"Service"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    serviceCostALDAHOL = roundf([[dictResults objectForKey:@"Service_Service Cost Per Scope_ALDAHOL"] floatValue]);
                    serviceCostAcecideC = roundf([[dictResults objectForKey:@"Service_Service Cost Per Scope_AcecideC"] floatValue]);
                    NSString* strServiceCompetition = [dictResults objectForKey:@"Service_Service Cost Per Scope_Competition"];
                    
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strServiceCompetition = [self stripDollarSign:strServiceCompetition];
                    strServiceCompetition = [self stripDecimalPoints:strServiceCompetition];
                    serviceCompetitionCost = [strServiceCompetition floatValue];
                    
                    NSDecimalNumber* decServiceCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", serviceCostALDAHOL]];
                    NSDecimalNumber* decServiceCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", serviceCostAcecideC]];
                    NSDecimalNumber* decServiceCompetitionCost = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", serviceCompetitionCost]];
                    
                    //convert to currency string
                    NSString* strServiceALDAHOLCost = [self convertToCurrencyString:decServiceCostALDAHOL];
                    NSString* strServiceAcecideCCost = [self convertToCurrencyString:decServiceCostAcecideC];
                    NSString* strServiceCompetitionCost = [self convertToCurrencyString:decServiceCompetitionCost];
                    
                    NSMutableArray* arrServiceResults = [[NSMutableArray alloc] init];
                    [arrServiceResults addObject:strServiceALDAHOLCost];
                    [arrServiceResults addObject:strServiceAcecideCCost];
                    [arrServiceResults addObject:strServiceCompetitionCost];
                    
                    [dictResultsData setObject:arrServiceResults forKey:@"Service Results"];
                    
                    OAI_Label* lblServiceCostALDAHOL = [dictResultCells objectForKey:@"Service Cost Per Scope ALDAHOL"];
                    lblServiceCostALDAHOL.text = strServiceALDAHOLCost;
                    
                    OAI_Label* lblServiceCostAcecideC = [dictResultCells objectForKey:@"Service Cost Per Scope AcecideC"];
                    lblServiceCostAcecideC.text = strServiceAcecideCCost;
                    
                    OAI_Label* lblServiceCostCompetition = [dictResultCells objectForKey:@"Service Cost Per Scope Competition"];
                    lblServiceCostCompetition.text = strServiceCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblServiceCostCompetition.alpha = 0.0;
                    } else {
                        lblServiceCostCompetition.alpha = 1.0;
                    }
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Chemicals"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    chemicalCostALDAHOL = [[dictResults objectForKey:@"Chemicals_Chemical Cost Per Scope_ALDAHOL"] floatValue];
                    chemicalCostAcecideC = [[dictResults objectForKey:@"Chemicals_Chemical Cost Per Scope_AcecideC"] floatValue];
                    NSString* strChemicalCompetition = [dictResults objectForKey:@"Chemicals_Chemical Cost Per Scope_Competition"];
                    //-->had to do this because for some reason the competition chemcical value was not translating to a float value
                    float thisNumber = [strChemicalCompetition floatValue];
                    chemicalCompetitionCost = thisNumber;
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strChemicalCompetition = [self stripDollarSign:strChemicalCompetition];
                    strChemicalCompetition = [self stripDecimalPoints:strChemicalCompetition];
                    
                    NSDecimalNumber* decChemicalCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", chemicalCostALDAHOL]];
                    NSDecimalNumber* decChemicalCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", chemicalCostAcecideC]];
                    NSDecimalNumber* decChemicalCompetitionCost = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f",  thisNumber]];
                    
                    //convert to currency string
                    NSString* strChemicalALDAHOLCost = [self convertToCurrencyString:decChemicalCostALDAHOL];
                    NSString* strChemicalAcecideCCost = [self convertToCurrencyString:decChemicalCostAcecideC];
                    NSString* strChemicalCompetitionCost = [self convertToCurrencyString:decChemicalCompetitionCost];
                    
                    NSMutableArray* arrChemicalResults = [[NSMutableArray alloc] init];
                    [arrChemicalResults addObject:strChemicalALDAHOLCost];
                    [arrChemicalResults addObject:strChemicalAcecideCCost];
                    [arrChemicalResults addObject:strChemicalCompetitionCost];
                    
                    [dictResultsData setObject:arrChemicalResults forKey:@"Chemical Results"];
                    
                    OAI_Label* lblChemicalCostALDAHOL = [dictResultCells objectForKey:@"Chemical Cost Per Scope ALDAHOL"];
                    lblChemicalCostALDAHOL.text = strChemicalALDAHOLCost;
                    
                    OAI_Label* lblChemicalCostAcecideC = [dictResultCells objectForKey:@"Chemical Cost Per Scope AcecideC"];
                    lblChemicalCostAcecideC.text = strChemicalAcecideCCost;
                    
                    OAI_Label* lblChemicalCostCompetition = [dictResultCells objectForKey:@"Chemical Cost Per Scope Competition"];
                    lblChemicalCostCompetition.text = strChemicalCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblChemicalCostCompetition.alpha = 0.0;
                    } else {
                        lblChemicalCostCompetition.alpha = 1.0;
                    }
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Detergents"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    detergentCostALDAHOL = [[dictResults objectForKey:@"Detergents_Detergent Cost Per Scope_ALDAHOL"] floatValue];
                    detergentCostAcecideC = [[dictResults objectForKey:@"Detergents_Detergent Cost Per Scope_AcecideC"] floatValue];
                    NSString* strDetergentCost = [dictResults objectForKey:@"Detergents_Detergent Cost Per Scope_Competition"];
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strDetergentCost = [self stripDollarSign:strDetergentCost];
                    strDetergentCost = [self stripDecimalPoints:strDetergentCost];
                    detergentCostCompetition = [strDetergentCost floatValue];
                    
                    //convert floats to NSDecimal
                    NSDecimalNumber* decDetergentCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", detergentCostALDAHOL]];
                    NSDecimalNumber* decDetergentCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", detergentCostAcecideC]];
                    NSDecimalNumber* decDetergentCostCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", detergentCostCompetition]];
                    
                    //convert to currency string
                    NSString* strDetergentALDAHOLCost = [self convertToCurrencyString:decDetergentCostALDAHOL];
                    NSString* strDetergentAcecideCCost = [self convertToCurrencyString:decDetergentCostAcecideC];
                    NSString* strDetergentCompetitionCost = [self convertToCurrencyString:decDetergentCostCompetition];
                    
                    NSMutableArray* arrDetergentResults = [[NSMutableArray alloc] init];
                    [arrDetergentResults addObject:strDetergentALDAHOLCost];
                    [arrDetergentResults addObject:strDetergentAcecideCCost];
                    [arrDetergentResults addObject:strDetergentCompetitionCost];
                    
                    [dictResultsData setObject:arrDetergentResults forKey:@"Detergent Results"];
                    
                    OAI_Label* lblDetergentCostALDAHOL = [dictResultCells objectForKey:@"Detergent Cost Per Scope ALDAHOL"];
                    lblDetergentCostALDAHOL.text = strDetergentALDAHOLCost;
                    
                    OAI_Label* lblDetergentCostAcecideC = [dictResultCells objectForKey:@"Detergent Cost Per Scope AcecideC"];
                    lblDetergentCostAcecideC.text = strDetergentAcecideCCost;
                    
                    OAI_Label* lblDetergentCostCompetition = [dictResultCells objectForKey:@"Detergent Cost Per Scope Competition"];
                    lblDetergentCostCompetition.text = strDetergentCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblDetergentCostCompetition.alpha = 0.0;
                    } else {
                        lblDetergentCostCompetition.alpha = 1.0;
                    }
                    
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Test Strips"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    testStripsCostALDAHOL = [[dictResults objectForKey:@"Test Strips_Test Strip Cost Per Scope_ALDAHOL"] floatValue];
                    testStripsCostAcecideC = [[dictResults objectForKey:@"Test Strips_Test Strip Cost Per Scope_AcecideC"] floatValue];
                    NSString* strTestStripsCost = [dictResults objectForKey:@"Test Strips_Test Strip Cost Per Scope_Competition"];
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strTestStripsCost = [self stripDollarSign:strTestStripsCost];
                    strTestStripsCost = [self stripDecimalPoints:strTestStripsCost];
                    testStripsCostCompetition = [strTestStripsCost floatValue];
                    
                    //convert floats to NSDecimal
                    NSDecimalNumber* decTestStripsCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", testStripsCostALDAHOL]];
                    NSDecimalNumber* decTestStripsCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", testStripsCostAcecideC]];
                    NSDecimalNumber* decTestStripsCostCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", testStripsCostCompetition]];
                    
                    //convert to currency string
                    NSString* strTestStripsALDAHOLCost = [self convertToCurrencyString:decTestStripsCostALDAHOL];
                    NSString* strTestStripsAcecideCCost = [self convertToCurrencyString:decTestStripsCostAcecideC];
                    NSString* strTestStripsCompetitionCost = [self convertToCurrencyString:decTestStripsCostCompetition];
                    
                    NSMutableArray* arrTestStripsResults = [[NSMutableArray alloc] init];
                    [arrTestStripsResults addObject:strTestStripsALDAHOLCost];
                    [arrTestStripsResults addObject:strTestStripsAcecideCCost];
                    [arrTestStripsResults addObject:strTestStripsCompetitionCost];
                    
                    [dictResultsData setObject:arrTestStripsResults forKey:@"Test Strip Results"];
                    
                    OAI_Label* lblTestStripsCostALDAHOL = [dictResultCells objectForKey:@"Test Strips Cost Per Scope ALDAHOL"];
                    lblTestStripsCostALDAHOL.text = strTestStripsALDAHOLCost;
                    
                    OAI_Label* lblTestStripsCostAcecideC = [dictResultCells objectForKey:@"Test Strips Cost Per Scope AcecideC"];
                    lblTestStripsCostAcecideC.text = strTestStripsAcecideCCost;
                    
                    OAI_Label* lblTestStripsCostCompetition = [dictResultCells objectForKey:@"Test Strips Cost Per Scope Competition"];
                    lblTestStripsCostCompetition.text = strTestStripsCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblTestStripsCostCompetition.alpha = 0.0;
                    } else {
                        lblTestStripsCostCompetition.alpha = 1.0;
                    }
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Filters"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    filtersCostALDAHOL = [[dictResults objectForKey:@"Filters_Filter Cost Per Scope_ALDAHOL"] floatValue];
                    filtersCostAcecideC = [[dictResults objectForKey:@"Filters_Filter Cost Per Scope_AcecideC"] floatValue];
                    NSString* strFiltersCost = [dictResults objectForKey:@"Filters_Filter Cost Per Scope_Competition"];
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strFiltersCost = [self stripDollarSign:strFiltersCost];
                    strFiltersCost = [self stripDecimalPoints:strFiltersCost];
                    filtersCostCompetition = [strFiltersCost floatValue];
                    
                    //convert floats to NSDecimal
                    NSDecimalNumber* decFiltersCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", filtersCostALDAHOL]];
                    NSDecimalNumber* decFiltersCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", filtersCostAcecideC]];
                    NSDecimalNumber* decFiltersCostCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", filtersCostCompetition]];
                    
                    //convert to currency string
                    NSString* strFilterALDAHOLCost = [self convertToCurrencyString:decFiltersCostALDAHOL];
                    NSString* strFilterAcecideCCost = [self convertToCurrencyString:decFiltersCostAcecideC];
                    NSString* strFilterCompetitionCost = [self convertToCurrencyString:decFiltersCostCompetition];
                    
                    NSMutableArray* arrFiltersResults = [[NSMutableArray alloc] init];
                    [arrFiltersResults addObject:strFilterALDAHOLCost];
                    [arrFiltersResults addObject:strFilterAcecideCCost];
                    [arrFiltersResults addObject:strFilterCompetitionCost];
                    
                    [dictResultsData setObject:arrFiltersResults forKey:@"Filter Results"];
                    
                    
                    OAI_Label* lblFilterCostALDAHOL = [dictResultCells objectForKey:@"Filters Cost Per Scope ALDAHOL"];
                    lblFilterCostALDAHOL.text = strFilterALDAHOLCost;
                    
                    OAI_Label* lblFilterCostAcecideC = [dictResultCells objectForKey:@"Filters Cost Per Scope AcecideC"];
                    lblFilterCostAcecideC.text = strFilterAcecideCCost;
                    
                    OAI_Label* lblFilterCostCompetition = [dictResultCells objectForKey:@"Filters Cost Per Scope Competition"];
                    lblFilterCostCompetition.text = strFilterCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblFilterCostCompetition.alpha = 0.0;
                    } else {
                        lblFilterCostCompetition.alpha = 1.0;
                    }
                    
                }
                
            } else if ([strThisKey rangeOfString:@"Labor"].location !=NSNotFound) {
                
                //look for our categories
                if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    
                    laborCostALDAHOL = [[dictResults objectForKey:@"Labor_Labor Cost Per Scope_ALDAHOL"] floatValue];
                    laborCostAcecideC = [[dictResults objectForKey:@"Labor_Labor Cost Per Scope_AcecideC"] floatValue];
                    NSString* strLaborCost = [dictResults objectForKey:@"Labor_Labor Cost Per Scope_Competition"];
                    
                    //get string, strip dollar symbols and decimal, convert to float
                    strLaborCost = [self stripDollarSign:strLaborCost];
                    strLaborCost = [self stripDecimalPoints:strLaborCost];
                    laborCostCompetition = [strLaborCost floatValue];
                    
                    //convert floats to NSDecimal
                    NSDecimalNumber* decLaborCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", laborCostALDAHOL]];
                    NSDecimalNumber* decLaborCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", laborCostAcecideC]];
                    NSDecimalNumber* decLaborCostCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", laborCostCompetition]];
                    
                    //convert to currency string
                    NSString* strLaborALDAHOLCost = [self convertToCurrencyString:decLaborCostALDAHOL];
                    NSString* strLaborAcecideCCost = [self convertToCurrencyString:decLaborCostAcecideC];
                    NSString* strLaborCompetitionCost = [self convertToCurrencyString:decLaborCostCompetition];
                    
                    NSMutableArray* arrLaborResults = [[NSMutableArray alloc] init];
                    [arrLaborResults addObject:strLaborALDAHOLCost];
                    [arrLaborResults addObject:strLaborAcecideCCost];
                    [arrLaborResults addObject:strLaborCompetitionCost];
                    
                    [dictResultsData setObject:arrLaborResults forKey:@"Labor Results"];
                    
                    OAI_Label* lblLaborCostALDAHOL = [dictResultCells objectForKey:@"Labor Cost Per Scope ALDAHOL"];
                    lblLaborCostALDAHOL.text = strLaborALDAHOLCost;
                    
                    OAI_Label* lblLaborCostAcecideC = [dictResultCells objectForKey:@"Labor Cost Per Scope AcecideC"];
                    lblLaborCostAcecideC.text = strLaborAcecideCCost;
                    
                    OAI_Label* lblLaborCostCompetition = [dictResultCells objectForKey:@"Labor Cost Per Scope Competition"];
                    lblLaborCostCompetition.text = strLaborCompetitionCost;
                    
                    if(!strSelectedCompetitor) {
                        lblLaborCostCompetition.alpha = 0.0;
                    } else {
                        lblLaborCostCompetition.alpha = 1.0;
                    }
                    
                }
                
            }
            
        }
        
        float totalsALDAHOL = serviceCostALDAHOL + chemicalCostALDAHOL + detergentCostALDAHOL + testStripsCostALDAHOL + filtersCostALDAHOL + laborCostALDAHOL;
        
        float totalsAcecideC = serviceCostAcecideC + chemicalCostAcecideC + detergentCostAcecideC + testStripsCostAcecideC + filtersCostAcecideC + laborCostAcecideC;
        
        float totalsCompetition = serviceCompetitionCost + chemicalCompetitionCost + detergentCostCompetition + testStripsCostCompetition + filtersCostCompetition + laborCostCompetition;
        
        //convert floats to NSDecimal
        NSDecimalNumber* decTotalsALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", totalsALDAHOL]];
        NSDecimalNumber* decTotalsAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", totalsAcecideC]];
        NSDecimalNumber* decTotalsCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", totalsCompetition]];
        
        strALDAHOLTotalCost = [self convertToCurrencyString:decTotalsALDAHOL];
        strAcecideCTotalCost = [self convertToCurrencyString:decTotalsAcecideC];
        strCompetitionTotalCost = [self convertToCurrencyString:decTotalsCompetition];
        
        NSMutableArray* arrTotalResults = [[NSMutableArray alloc] init];
        [arrTotalResults addObject:strALDAHOLTotalCost];
        [arrTotalResults addObject:strAcecideCTotalCost];
        [arrTotalResults addObject:strCompetitionTotalCost];
        
        [dictResultsData setObject:arrTotalResults forKey:@"Total Results"];
        
        OAI_Label* lblTotalCostALDAHOL = [dictResultCells objectForKey:@"Total Cost Per Scope ALDAHOL"];
        lblTotalCostALDAHOL.text = strALDAHOLTotalCost;
        
        OAI_Label* lblTotalCostAcecideC = [dictResultCells objectForKey:@"Total Cost Per Scope AcecideC"];
        lblTotalCostAcecideC.text = strAcecideCTotalCost;
        
        OAI_Label* lblTotalCostCompetition = [dictResultCells objectForKey:@"Total Cost Per Scope Competition"];
        lblTotalCostCompetition.text = strCompetitionTotalCost;
        
        if (!strSelectedCompetitor) {
            lblTotalCostCompetition.alpha = 0.0;
        } else {
            lblTotalCostCompetition.alpha = 1.0;
        }
        
        //getting the y location of the chart
        lastLabelY = lblTotalCostALDAHOL.frame.origin.y + lblTotalCostALDAHOL.frame.size.height + 10.0;
    }
    
    //get the page to add the chart to
    NSArray* arrPages = scNav.subviews;
    
    //check to see if tableview is displayed
    CGRect compFrame = vCompChoices.frame;
    if (compFrame.size.height > 1) {
        [self showCompetitors:nil];
    }
    
    //scroll to the page
    for(UIView* vThisView in arrPages) {
        
        if (vThisView.frame.origin.x == 772.0) {
            NSArray* arrResultsSubviews = vThisView.subviews;
            scResultsScrollView = [arrResultsSubviews objectAtIndex:1];
        }
    }
    
    [self getTimeSavings];
    
    //set up a point
    float pageX = 1 * 772.0;
    float pageY = 0.0;
    CGPoint scrollOffset = CGPointMake(pageX, pageY);
    
    //move the scroll offset to that point
    [scNav setContentOffset:scrollOffset animated:YES];
    
}

- (void) getTimeSavings {
    
    float timeSavingsALDAHOLTotals = 0.0;
    float timeSavingsAcedideCTotals = 0.0;
    float timeSavingsCompetitionTotals = 0.0;
    
    
    //loop through the results
    for(NSString* strThisKey in dictResults) {
        
        //make sure we are dealing with operation time results
        if ([strThisKey rangeOfString:@"Operation Time_"].location !=NSNotFound) {
            
            //get the cell value
            NSString* strThisValue = [dictResults objectForKey:strThisKey];
            
            //get the suffix
            NSArray* arrThisKey = [strThisKey componentsSeparatedByString:@"_"];
            
            //add up the totals
            if ([[arrThisKey objectAtIndex:2] isEqualToString:@"ALDAHOL"]) {
                timeSavingsALDAHOLTotals = timeSavingsALDAHOLTotals + [strThisValue floatValue];
            } else if ([[arrThisKey objectAtIndex:2] isEqualToString:@"AcecideC"]) {
                timeSavingsAcedideCTotals = timeSavingsAcedideCTotals + [strThisValue floatValue];
            } else if ([[arrThisKey objectAtIndex:2] isEqualToString:@"Competition"]) {
                timeSavingsCompetitionTotals = timeSavingsCompetitionTotals + [strThisValue floatValue];
            }
            
            //set up the key for the dictCells and dump data as array into dictResultsData
            NSString* strThisObj;
            
            
            
            if ([strThisKey rangeOfString:@"Post"].location != NSNotFound) {
                strThisObj = [NSString stringWithFormat:@"Post-AER Processing_%@", [arrThisKey objectAtIndex:2]];
            } else { 
                strThisObj = [NSString stringWithFormat:@"%@_%@", [arrThisKey objectAtIndex:1], [arrThisKey objectAtIndex:2]];
            }
            
            //get the right label and pass the value to it
            if ([dictResultCells objectForKey:strThisObj]) {
                OAI_Label* lblThisLabel = [dictResultCells objectForKey:strThisObj];
                lblThisLabel.text = strThisValue;
                
                if ([[arrThisKey objectAtIndex:2] isEqualToString:@"Competition"]) {
                    if (!strSelectedCompetitor) {
                        lblThisLabel.alpha = 0.0;
                    } else {
                        lblThisLabel.alpha = 1.0;
                    }
                }
            }
            
        }
        
    }
    
    //add the total times
    for(NSString* strThisCellKey in dictResultCells) {
        
        OAI_Label* lblThisLabel = [dictResultCells objectForKey:strThisCellKey];
        
        if([strThisCellKey rangeOfString:@"Total Time"].location !=NSNotFound) {
            if([strThisCellKey rangeOfString:@"ALDAHOL"].location != NSNotFound) {
                lblThisLabel.text = [NSString stringWithFormat:@"%.00f", timeSavingsALDAHOLTotals];
            } else if ([strThisCellKey rangeOfString:@"AcecideC"].location != NSNotFound) {
                lblThisLabel.text = [NSString stringWithFormat:@"%.00f", timeSavingsAcedideCTotals];
            } else if ([strThisCellKey rangeOfString:@"Competition"].location != NSNotFound) {
                lblThisLabel.text = [NSString stringWithFormat:@"%.00f", timeSavingsCompetitionTotals];
                
                if (!strSelectedCompetitor) {
                    lblThisLabel.alpha = 0.0;
                } else {
                    lblThisLabel.alpha = 1.0;
                }
            }
        }
    }
    
    //get the header label
    OAI_Label* lblThisLabel = [dictResultCells objectForKey:@"Competitor"];
    if (!strSelectedCompetitor) {
        lblThisLabel.alpha = 0.0;
    } else {
        lblThisLabel.alpha = 1.0;
        lblThisLabel.text = strSelectedCompetitor;
    }

    NSArray* arrResultCellKeys = [dictResultCells allKeys];
    NSArray* arrSuffixes = [[NSArray alloc] initWithObjects:@"ALDAHOL", @"AcecideC", @"Competition", nil];
    for(int i=0; i<arrTimeSavingsRowHeaders.count; i++) {
        
        NSMutableArray* arrTempArray = [[NSMutableArray alloc] init];
        
        for(int y=0; y<arrSuffixes.count; y++) {
            
            
            
            NSString* strThisKey = [NSString stringWithFormat:@"%@_%@", [arrTimeSavingsRowHeaders objectAtIndex:i], [arrSuffixes objectAtIndex:y]];
            
            if ([arrResultCellKeys containsObject:strThisKey]) {
                
                OAI_Label* lblThisLabel = [dictResultCells objectForKey:strThisKey];
                [arrTempArray addObject:lblThisLabel.text];
            }
        }
        
        [dictResultsData setObject:arrTempArray forKey:[arrTimeSavingsRowHeaders objectAtIndex:i]];
    }


}

- (void) showCalculations : (UIButton*) myButton {
    
    //set up a point
    float pageX = 0.0;
    float pageY = 0.0;
    CGPoint scrollOffset = CGPointMake(pageX, pageY);
    
    //move the scroll offset to that point
    [scNav setContentOffset:scrollOffset animated:YES];
}

- (void) resetComparisonDisplay : (NSString*) strThisRowHeader : (OAI_CheckBox*) thisCheckbox {
    
    for(int i=0; i<arrResultsRowHeaders.count; i++) {
        
        if ([strThisRowHeader isEqualToString:[arrResultsRowHeaders objectAtIndex:i]]) {
        
            OAI_Label* lblThisRowHeader = [arrResultsRowHeaderLabels objectAtIndex:i];
            
            if (thisCheckbox.isChecked) {
                lblThisRowHeader.textColor = [UIColor blackColor];
            } else {
                lblThisRowHeader.textColor = [UIColor redColor];
            }
        }
    }
    
    [self totalComparisons];
}

- (void) totalComparisons {
    
    //set the bool to yes
    hasItems = YES;
    
    int cpsCount = 0;
    competitionTotal = 0.0;
    aldaholTotal = 0.0;
    acedicdeTotal = 0.0;
    
    //loop through the checkboxes
    for(int i=0; i<arrResultsRowHeaderChecks.count; i++) {
        
        //get a checkbox
        OAI_CheckBox* thisCheckbox = [arrResultsRowHeaderChecks objectAtIndex:i];
        
        //check if it is checked or not
        if (thisCheckbox.isChecked) {
            
            //get what row it is related to
            NSString* strThisRowType = thisCheckbox.strMyOperCostType;
            
            //get just the type name
            NSArray* arrRowTypeWords = [strThisRowType componentsSeparatedByString:@" "];
            NSString* strThisType = [arrRowTypeWords objectAtIndex:2];
            
            //loop through the dictionary that holds the results cells
            for(NSString* strThisKey in dictResultCells) {
                
                //look for the items that match this row type (cost of xxxx per scope)
                if ([strThisKey rangeOfString:strThisType].location !=NSNotFound) {
                    
                    //extract the label from the dict
                    OAI_Label* lblThisResult = [dictResultCells objectForKey:strThisKey];
                    
                    //get its value
                    NSString* strThisValue = lblThisResult.text;
                    strThisValue = [self stripDollarSign:strThisValue];
                    float thisValue = [strThisValue floatValue];
                    
                    //check which item we are totaling
                    if ([strThisKey rangeOfString:@"AcecideC"].location !=NSNotFound) {
                        acedicdeTotal = acedicdeTotal + thisValue;
                    } else if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                        aldaholTotal = aldaholTotal+ thisValue;
                    } else if ([strThisKey rangeOfString:@"Competition"].location !=NSNotFound) {
                        competitionTotal = competitionTotal + thisValue;
                    }
                    
                    cpsCount = cpsCount + 1;
                    
                }
            }
        }
        
    }
    
    if (cpsCount > 0) {
        
        //convert the totals to currency
        NSDecimalNumber* decTotalCostAcecideC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", acedicdeTotal]];
        NSDecimalNumber* decTotalCostALDAHOL = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", aldaholTotal]];
        NSDecimalNumber* decTotalCostCompetition = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", competitionTotal]];
        
        NSString* strTotalCostAcecideC = [self convertToCurrencyString:decTotalCostAcecideC];
        NSString* strTotalCostALDAHOL = [self convertToCurrencyString:decTotalCostALDAHOL];
        NSString* strTotalCostCompetition = [self convertToCurrencyString:decTotalCostCompetition];
        
        //loop through the dictionary that holds the results cells - looking for the totals cells
        for(NSString* strThisKey in dictResultCells) {
          
            if ([strThisKey rangeOfString:@"Total"].location !=NSNotFound) {
                
                OAI_Label* lblThisLabel = [dictResultCells objectForKey:strThisKey];
             
                //check which item we are totaling
                if ([strThisKey rangeOfString:@"AcecideC"].location !=NSNotFound) {
                    lblThisLabel.text = strTotalCostAcecideC;
                } else if ([strThisKey rangeOfString:@"ALDAHOL"].location !=NSNotFound) {
                    lblThisLabel.text = strTotalCostALDAHOL;
                } else if ([strThisKey rangeOfString:@"Competition"].location !=NSNotFound) {
                    lblThisLabel.text = strTotalCostCompetition;
                }
            }
        }
        
    } else {
        
        hasItems = NO;
        
    }
}

#pragma mark - Email Methods

- (void) toggleEmailSetup : (UIButton*) myButton; {
    
    if (hasItems) { 
    
        CGRect emailManagerFrame = vEmailManager.frame;
        
        if (emailManagerFrame.origin.y == -400.0) {
            emailManagerFrame.origin.y = 0.0;
        } else {
            emailManagerFrame.origin.y = 0.0-400.0;
        }
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             vEmailManager.frame = emailManagerFrame;
                         }
         
                         completion:^(BOOL finished){
                             nil;
                         }
         
         ];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]
          initWithTitle: @"Comparison Warning"
          message: @"You must select at least one item to send out an email."
          delegate: nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:
          nil];
        
        [alert show];
    }
    


}

- (void) sendEmail {
    
    //close the email win
    [self toggleEmailSetup:nil];
    
    //[emailBody appendString:[NSString stringWithFormat:@"<div></div>"]];
    //style=\"\"
    
    //get which items we are going to list
    BOOL showALDAHOL = NO;
    BOOL showAcecide = NO;
    BOOL showCompetitor = NO;
    
    for(int i=0; i<arrEmailCheckboxes.count; i++) {
        
        OAI_SimpleCheckbox* thisCheckbox = [arrEmailCheckboxes objectAtIndex:i];
        
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
    
    //set the subject
    NSString* emailSubject = [NSString stringWithFormat:@"Operational Cost Projections With the Olympus OER-Pro for %@",strFacilityName];
    
    //set up the body
    NSMutableString* emailBody = [[NSMutableString alloc] init];
    
    //intro
    [emailBody appendString:[NSString stringWithFormat:@"<div style=\"color:#666; font-weight: 200; font-size:16px; font-family: sans-serif, helvetica, arial;\">Below are the results of the Operational Cost Projections With the Olympus OER-Pro for %@.</div>", strFacilityName]];
    
    //table title
    OAI_TextField* txtProcuedureCount = [dictTextFields objectForKey:@"Procedure Count"];
    [emailBody appendString:[NSString stringWithFormat:@"<div style=\"font-weight: 900; font-size:18px; color:#666; padding-top: 10px; padding-bottom:10px\">Annual Volume: %@</div>", txtProcuedureCount.text]];
    
    [emailBody appendString:@"<div><table style=\"width: 700px; font-size:14px\"><thead><tr>"];
    
    //headers
    for(int i=0; i<arrResultsTableHeaders.count; i++) {
        
        NSString* strThisHeader = [arrResultsTableHeaders objectAtIndex:i];
        BOOL showHeader = NO;
        
        
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
                strThisHeader = strSelectedCompetitor;
            }
        } else if (i==0) {
            showHeader = YES;
        }


        int width = 125;
        if (i==0) {
            width= 225;
        }
        
        if (showHeader) { 
            [emailBody appendString:[NSString stringWithFormat:@"<th style=\"background-color:#08107b; color:#fff; width:%ipx;\">%@</th>", width, strThisHeader]];
        }
    
    
        //reset
        showHeader = NO;
    
    }
    
    [emailBody appendString:@"</tr></thead><tbody>"];
    
    //content
    
    for(int i=0; i<arrResultsRowHeaders.count; i++) {
        
        NSString* strRowColor;
        if (i%2) {
            strRowColor = @"#fdecbe";
        } else {
            strRowColor = @"#e6e6e6";
        }
        
        
        //get whether the user wants to display this row
        BOOL isChecked = YES;
        if (i<6) { 
            OAI_CheckBox* thisCheckbox = [arrResultsRowHeaderChecks objectAtIndex:i];
            isChecked = thisCheckbox.isChecked;
        }
        
        NSArray* arrThisData;
        //get the correct array and check if we are going to display it based on the checkbox
        if (i==0) {
            arrThisData = [dictResultsData objectForKey:@"Service Results"];
            
        } else if (i==1) {
            arrThisData = [dictResultsData objectForKey:@"Chemical Results"];
        } else if (i==2) {
            arrThisData = [dictResultsData objectForKey:@"Detergent Results"];
        } else if (i==3) {
            arrThisData = [dictResultsData objectForKey:@"Test Strip Results"];
        } else if (i==4) {
            arrThisData = [dictResultsData objectForKey:@"Filter Results"];
        } else if (i==5) {
            arrThisData = [dictResultsData objectForKey:@"Labor Results"];
        } else if (i==6) {
            arrThisData = [dictResultsData objectForKey:@"Total Results"];
        }
        
        if (isChecked) {
            
            NSString* strThisRowHeader = [arrResultsRowHeaders objectAtIndex:i];
            [emailBody appendString:[NSString stringWithFormat:@"<tr><td style=\"background-color:%@; height:20px;\">%@</td>", strRowColor, strThisRowHeader]];
            
            for(int x=0; x<arrThisData.count; x++) {
                
                //get the cell values (except for the totals, which can change based on what is to be displayed in the email)
                NSString* strThisData;
                if (i<6) { 
                    strThisData = [arrThisData objectAtIndex:x];
                } else {
                    //add the total times
                    for(NSString* strThisCellKey in dictResultCells) {
                        
                        OAI_Label* lblThisLabel = [dictResultCells objectForKey:strThisCellKey];
                        
                        if([strThisCellKey rangeOfString:@"Total Time"].location !=NSNotFound) {
                            if([strThisCellKey rangeOfString:@"ALDAHOL"].location != NSNotFound) {
                                strThisData = lblThisLabel.text;
                            } else if ([strThisCellKey rangeOfString:@"AcecideC"].location != NSNotFound) {
                                strThisData = lblThisLabel.text;
                            } else if ([strThisCellKey rangeOfString:@"Competition"].location != NSNotFound) {
                                strThisData = lblThisLabel.text;
                            }
                        }
                    }
                }
                
                BOOL showCell = NO;
                //determine if the cell should be displayed or not
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
            
                //show the cell
                if (showCell) { 
                    [emailBody appendString:[NSString stringWithFormat:@"<td style=\"background-color:%@; height:20px;\">%@</td>", strRowColor, strThisData]];
                }
                
                //reset
                showCell = NO;
            }
            
        }
        
        [emailBody appendString:@"</tr>"];
        
        //reset isChecked
        isChecked = YES;
    }
    
    [emailBody appendString:@"</tbody></table></div><p>"];
    
    //comparison notes
    NSString* strCostNotes = @"<div>The additional cost of the OER-Pro with Acecide may be offset by the time and safety improvements noted in this document.<p>The OER-Pro is designed to reprocess two endoscopes per cycle. The \"cost per scope\" reflects the cost for reprocessing one scope when scopes are reprocessed per cycle.</p><p>The number of cycles and the cost of filters per case varies depending on water quality and is difficult to project. Filter costs for an Olympus-purchased prefiltration system are included in this tool. Additionally, other factors such as test strip interpretation, selected chemistry and other environmental factors great influence the number of cycles before a change is required. The projected numbers provided in this calculator are only an estimate. Olympus suggests meeting with your Clinical Bioengineering Department to address local issues related to this expense.</div></p>";
    
    [emailBody appendString:strCostNotes];
    
    //start time savings table
    [emailBody appendString:@"<div style=\"font-weight: 900; font-size:18px; color:#666; padding-top: 10px; padding-bottom:10px\">Time Savngs:</div>"];
    
    [emailBody appendString:@"<div><table style=\"width: 700px; font-size:14px\"><thead><tr>"];
    
    
    for(int i=0; i<arrTypes.count+1; i++) {
        
        NSString* strThisHeader;
        BOOL showHeader = NO;
        int width = 125;
        
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
                strThisHeader = strSelectedCompetitor;
            }
        } else if (i==0) {
            showHeader = YES;
        }

        
        if (i==0) {
            width= 225;
            strThisHeader = @"";
        } else {
            strThisHeader = [arrTypes objectAtIndex:i-1];
        }
        
        if (showHeader) {
            [emailBody appendString:[NSString stringWithFormat:@"<th style=\"background-color:#08107b; color:#fff; width:%ipx;\">%@</th>", width, strThisHeader]];
        }
        
        //reset
        showHeader = NO;
    }
    
    for(int i=0; i<arrTimeSavingsRowHeaders.count; i++) {
        
        NSArray* arrThisData;
        
        NSString* strRowColor;
        if (i%2) {
            strRowColor = @"#fdecbe";
        } else {
            strRowColor = @"#e6e6e6";
        }
        
        NSString* strThisRowHeader = [arrTimeSavingsRowHeaders objectAtIndex:i];
        
        [emailBody appendString:[NSString stringWithFormat:@"<tr><td style=\"background-color:%@; height:20px;\">%@</td>", strRowColor, strThisRowHeader]];
        
        
        //get the correct array
        if (i==0) {
            arrThisData = [dictResultsData objectForKey:@"Pre-Cleaning"];
        } else if (i==1) {
            arrThisData = [dictResultsData objectForKey:@"Leakage Testing"];
        } else if (i==2) {
            arrThisData = [dictResultsData objectForKey:@"Manual Cleaning"];
        } else if (i==3) {
            arrThisData = [dictResultsData objectForKey:@"AER Processing"];
        } else if (i==4) {
            arrThisData = [dictResultsData objectForKey:@"Post-AER Processing"];
        } else if (i==5) {
            arrThisData = [dictResultsData objectForKey:@"Total Time Per Cycle (Minutes)    "];
        }
        
        for(int x=0; x<arrThisData.count; x++) {
            
            NSString* strThisData = [arrThisData objectAtIndex:x];
            
            BOOL showCell = NO;
            
            //determine if the cell should be displayed or not
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
                [emailBody appendString:[NSString stringWithFormat:@"<td style=\"background-color:%@; height:20px;\">%@</td>", strRowColor, strThisData]];
            }
            //reset
            showCell = NO;
        }
        
        [emailBody appendString:@"</tr>"];
    }
    
    [emailBody appendString:@"</tbody></table></div><p>"];
    
    //time notes
    [emailBody appendString:@"<div><p style=\"font-weight:900;\">OER-Pro Time Values:</p><p>Our intimate knowledge of endoscope design allows us to use proprietary technologies to provide you with an enhanced reprocessing experience. As part of that experience, the OER-Pro eliminates 7 of the 11 recommended manual cleaning steps.</p><p style=\"font-weight:900;\">Acecide-C:</p><p>Conservatively Acecide-C saving estimate vs. ALDAHOL is: 9 minutes</p><p>Annual staff time savings is estimated to be at least: 300 hours</p><p>At $15 per hour, this annual savings totals: $4500</p></div>"];
    
    //build pdf
    pdfManager.strFacilityName = strFacilityName;
    pdfManager.arrEmailCheckboxes = arrEmailCheckboxes;
    
    NSString* strPDFFileName = [NSString stringWithFormat:@"OER_Pro_Cost_%@.pdf", strFacilityName];
    [dictResultsData setObject:arrResultsTableHeaders forKey:@"Results Table Headers"];
    [dictResultsData setObject:arrResultsRowHeaders forKey:@"Results Row Headers"];
    [dictResultsData setObject:arrTimeSavingsRowHeaders forKey:@"Time Savings Row Headers"];
    [dictResultsData setObject:arrTypes forKey:@"Time Savings Headers"];
    
    [pdfManager makePDF:strPDFFileName :dictResultsData];
    
    //check to make sure the app can send email
    if ([MFMailComposeViewController canSendMail]) {
        
        //init a mail view controller
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
        NSArray* bccRecipients = [[NSArray alloc] initWithObjects:@"steve.suranie@olympus.com", nil];
        
        [mailViewController setBccRecipients:bccRecipients];
        
        //set delegate
        mailViewController.mailComposeDelegate = self;
        
        [mailViewController setSubject:emailSubject];
        
        [mailViewController setMessageBody:emailBody isHTML:YES];
        
        
        /**********Attach PDF Files**************/
        //get path to pdf file
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString* pdfFilePath = [documentsDirectory stringByAppendingPathComponent:strPDFFileName];
        
        //convert pdf file to NSData
        NSData* pdfData = [NSData dataWithContentsOfFile:pdfFilePath];
        
        //attach the pdf file
        [mailViewController addAttachmentData:pdfData mimeType:@"application/pdf" fileName:strPDFFileName];
        
        //make sure the pdf file is in the documents directory
        [fileManager moveFileToDocDirectory:@"OER_MarketingContent.pdf" :@"There was a problem moving the PDF file into the documents directory."];
        
        //get path to pdf file
        NSString* pdf2FilePath = [documentsDirectory stringByAppendingPathComponent:@"OER_MarketingContent.pdf"];
        
        //convert pdf file to NSData
        NSData* pdf2Data = [NSData dataWithContentsOfFile:pdf2FilePath];
        
        //attach the pdf file
        [mailViewController addAttachmentData:pdf2Data mimeType:@"application/pdf" fileName:@"OER_MarketingContent.pdf"];
    
        
        
        [self presentViewController:mailViewController animated:YES completion:NULL];
        
    } else {
        
        NSLog(@"Device is unable to send email in its current state.");
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result){
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email was sent");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
            
        default:
            NSLog(@"Mail not sent");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard Methods
- (void) keyboardDidShow:(NSNotification*)notification {
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows]objectAtIndex:0];
    UIView *mainSubviewOfWindow = window.rootViewController.view;
    CGRect keyboardFrameConverted = [mainSubviewOfWindow convertRect:keyboardFrame fromView:window];
    
    myKeyboardFrame = keyboardFrameConverted;
    
    [self checkKeyboardConflict];
}

-(void)keyboardWillHide:(NSNotification*)notification{
    
    //[scSections setContentOffset:myScrollViewOrigiOffSet animated:YES];
}

- (void) checkKeyboardConflict {
    
    //get the first responder
    UIView* vFirstResponder = [self findFirstResponder:self.view];
    BOOL isTextField = NO;
    UIView* vParent;
    float objDiff;
    
    //make sure we are working wiht a text field
    if ([vFirstResponder isMemberOfClass:[OAI_TextField class]]) {
        
        isTextField = YES;
        
        if ((vFirstResponder.frame.origin.y+300.0) > myKeyboardFrame.origin.y) {
            
            //get the difference between the two origins
            objDiff = ((vFirstResponder.frame.origin.y+440.0) - myKeyboardFrame.origin.y);
            
            //scroll view frame
            CGPoint svOffSet = CGPointMake(myScrollViewOrigiOffSet.x, 0+objDiff);
            
            [scSections setContentOffset:svOffSet animated:YES];
        }
    }
}

#pragma mark - Dismiss Keyboard

- (void) dismissKeyboard {
    
    UIView* firstResponder = [self findFirstResponder:self.view];
    [firstResponder resignFirstResponder];
    
}

- (UIView *)findFirstResponder : (UIView*) viewToSearch {
    
    if (viewToSearch.isFirstResponder) {
        return viewToSearch;
    }
    
    for (UIView *subView in viewToSearch.subviews) {
        UIView* firstResponder = [self findFirstResponder:subView];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}




#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //store the current text field data
    strCurrentTextFieldValue = textField.text;
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(OAI_TextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
    
}

- (void)textFieldDidEndEditing:(OAI_TextField *)textField {
        
    //trapping for account info text fields
    if (textField.tag > 600 && textField.tag < 605) {
        
        //set some ivars
        NSString* strAccountPlist = @"UserAccount.plist";
        NSMutableDictionary* dictAccountData = [[NSMutableDictionary alloc] init];
        
        //get all the text fields
        NSArray* arrAccountSubviews = vAccount.subviews;
        
        //loop through elements of vAccount
        for(int i=0; i<arrAccountSubviews.count; i++) {
            
            //sniff for textfields
            if ([[arrAccountSubviews objectAtIndex:i] isMemberOfClass:[UITextField class]]) {
                
                //cast to textfield
                UITextField* thisTextField = (UITextField*)[arrAccountSubviews objectAtIndex:i];
                
                //check which textfield we captured and then dump data into dictionary
                if (thisTextField.text != nil) {
                    if (thisTextField.tag == 601) {
                        [dictAccountData setObject:thisTextField.text forKey:@"User Name"];
                    } else if (thisTextField.tag == 602) {
                        [dictAccountData setObject:thisTextField.text forKey:@"User Title"];
                    } else if (thisTextField.tag == 603) {
                        [dictAccountData setObject:thisTextField.text forKey:@"User Email"];
                    } else if (thisTextField.tag == 604) {
                        [dictAccountData setObject:thisTextField.text forKey:@"User Phone"];
                    }
                }
            }
        }
        
        //create the plist if we need to
        [fileManager createPlist:strAccountPlist];
        
        [fileManager writeToPlist:strAccountPlist :dictAccountData];
        
    } else { 
    
        //set up the bool
        BOOL isValid = YES;
        
        //make sure there is an entry
        if(textField.text.length > 0 || textField.text != nil) {
            
            //validate it
            isValid = [self validateEntries:textField.textFieldTitle:textField];
            
        }
        
        //if valid calculate the results
        if (isValid) {
            
            if (textField.tag == 800) {
            
                float textFieldValue = [textField.text floatValue];
                
                if (textFieldValue > .99)  {
                    //convert to percentage
                    textFieldValue = textFieldValue/100;
                    //reset the value
                    textField.text = [NSString stringWithFormat:@"%f", textFieldValue];
                }
                
                if (textFieldValue > .105) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                      initWithTitle: @"Discount Error"
                      message: @"Discounts cannot exceed 10 percent!"
                      delegate: nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:
                      nil];
                    
                    [alert show];
                    
                    textField.text = strCurrentTextFieldValue;
                
                } else {
                    
                    /*
                    //fill in the other chem discount
                    for(NSString* strThisKey in dictTextFields) {
                        if([[dictTextFields objectForKey:strThisKey] isMemberOfClass:[OAI_TextField class]]) {
                            
                            OAI_TextField* txtThisField = (OAI_TextField*)[dictTextFields objectForKey:strThisKey];
                            
                            
                            
                            if(txtThisField !=textField) { 
                            
                                if ([strThisKey rangeOfString:@"Chemical"].location != NSNotFound) {
                                    
                                    if ([txtThisField.textFieldTitle rangeOfString:@"Competition"].location == NSNotFound) {
                                        txtThisField.text = textField.text;
                                    }
                                
                                }
                            }
                            
                        }
                    }
                     */

                    //calculate the discount
                    [self calculate:@"Chemicals":NO];
                    
                }
                
            } else if(textField.tag == 801) {
                
                //other discounts
                
                float textFieldValue = [textField.text floatValue];
                
                if (textFieldValue > .99)  {
                    //convert to percentage
                    textFieldValue = textFieldValue/100;
                    //reset the value
                    textField.text = [NSString stringWithFormat:@"%f", textFieldValue];
                }
                
                if (textFieldValue > .105) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                      initWithTitle: @"Discount Error"
                      message: @"Discounts cannot exceed 10 percent!"
                      delegate: nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:
                      nil];
                    
                    [alert show];
                    
                    textField.text = strCurrentTextFieldValue;
                    
                } else {
                    
                    //fill in the discount for each section
                    [self setDiscount:textField.text];
                    
                    [self calculate:@"Other":NO];
                    
                }
                
                
            } else if (textField.tag == 802) {
                
                //labor text field
                BOOL isLaborValid = YES;
                
                NSString* strWorkingString = textField.text;
                
                //check to see if user put in just a text string
                NSCharacterSet* alphaSet = [NSCharacterSet characterSetWithCharactersInString:@"$.0123456789"];
                alphaSet = [alphaSet invertedSet];
                NSRange r = [strWorkingString rangeOfCharacterFromSet:alphaSet];
                if (r.location != NSNotFound) {
                    isLaborValid = NO;
                }
                
                if (!isLaborValid) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                      initWithTitle: @"Labor Cost Error"
                      message: @"Please enter a numeric or currency figure in this section."
                      delegate: nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:
                      nil];
                    
                    [alert show];
                    
                    //replace with initial item
                    textField.text = strCurrentTextFieldValue;
                    
                } else {
                    
                    strWorkingString = [self stripDollarSign:strWorkingString];
                    
                    //convert str to decimal
                    NSDecimalNumber* decCurrency = [[NSDecimalNumber alloc] initWithString:strWorkingString];
                    
                    //convert string to currency
                    textField.text = [self convertToCurrencyString:decCurrency];
                    
                    [self calculate:@"Labor":NO];
                    
                }
            
            } else if (textField.tag == 803) {

                float textFieldValue = [textField.text floatValue];
                if (textFieldValue > .105) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Discount Error"
                                          message: @"Discounts cannot exceed 10 percent!"
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:
                                          nil];
                    
                    [alert show];
                    
                    textField.text = strCurrentTextFieldValue;
                    
                } else {
                    
                    
                    [self calculate:@"Service":NO];
                    
                    //fill in the discount for each section
                    [self setDiscount:textField.text];
                    
                }
                
            } else if (textField.tag == 804) {
                
                
                
                //labor text field
                BOOL isServiceValid = YES;
                
                NSString* strWorkingString = textField.text;
                
                //check to see if user put in just a text string
                NSCharacterSet* alphaSet = [NSCharacterSet characterSetWithCharactersInString:@"$.0123456789"];
                alphaSet = [alphaSet invertedSet];
                NSRange r = [strWorkingString rangeOfCharacterFromSet:alphaSet];
                if (r.location != NSNotFound) {
                    isServiceValid = NO;
                }
                
                if (!isServiceValid) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Labor Cost Error"
                                          message: @"Please enter a numeric or currency figure in this section."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:
                                          nil];
                    
                    [alert show];
                    
                    //replace with initial item
                    textField.text = strCurrentTextFieldValue;
                    
                } else {
                    
                    strWorkingString = [self stripDollarSign:strWorkingString];
                    
                    //convert str to decimal
                    NSDecimalNumber* decCurrency = [[NSDecimalNumber alloc] initWithString:strWorkingString];
                    
                    //convert string to currency
                    strWorkingString = [self convertToCurrencyString:decCurrency];
                    
                    textField.text = strWorkingString;
                    
                    [self calculate:@"Service":NO];
                    
                    
                }
                
                
            } else {
                
                [self calculate:@"All":NO];
            }
        }
        
    }
}

- (void) setDiscount : (NSString*) strDiscount {
    
    NSArray* arrDiscountFields = [[NSArray alloc] initWithObjects:@"Detergents_Discount_ALDAHOL", @"Detergents_Discount_AcecideC", @"Filters_Discount_AcecideC", @"Filters_Discount_ALDAHOL", @"Service_Discount_ALDAHOL", @"Service_Discount_AcecideC", @"Test Strips_Discount_ALDAHOL", @"Test Strips_Discount_AcecideC", nil];
    
    for(NSString* strThisKey in dictTextFields) {
        if([[dictTextFields objectForKey:strThisKey] isMemberOfClass:[OAI_TextField class]]) {
            OAI_TextField* txtThisField = (OAI_TextField*)[dictTextFields objectForKey:strThisKey];
            
            if ([arrDiscountFields containsObject:txtThisField.textFieldTitle]) {
                txtThisField.text = strDiscount;
            }
            
        }
    }
    
}



#pragma mark - Tap Gesture Recognizer Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}



#pragma mark - Table View Management
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrCompetitorNames.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSString* strCellValue = [arrCompetitorNames objectAtIndex:indexPath.row];
    CGSize cellValueSize = [strCellValue sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15.0] constrainedToSize:CGSizeMake(cell.frame.size.width-10.0, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    //reset the cell frame
    CGRect cellFrame = cell.frame;
    cellFrame.size.height = cellValueSize.height;
    cell.frame = cellFrame;
    
    cell.textLabel.text = [arrCompetitorNames objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [colorManager setColor:66.0 :66.0 :66.0];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView* vCellBackground = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
    if (indexPath.row %2) {
        vCellBackground.backgroundColor = [colorManager setColor:204. :204. :204.0];
    } else {
        vCellBackground.backgroundColor = [colorManager setColor:247: 235 :184];
    }

    cell.backgroundView = vCellBackground;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    strSelectedCompetitor = [arrCompetitorNames objectAtIndex:indexPath.row];
    
    //collapse table view
    [self showCompetitors:nil];
    [self addCompetitorTimes];
    
    //change the competitor on the comparison page
    NSArray* arrScrollViews = scNav.subviews;
    UIView* vComparisonPage = [arrScrollViews objectAtIndex:2];
    
    //change the label on the comparison chart
    UILabel* lblThisLabel = (UILabel*)[vComparisonPage viewWithTag:100];
    lblThisLabel.text = strSelectedCompetitor;
    
    //pass the competitor to the email manager
    vEmailManager.strSelectedCompetitor = strSelectedCompetitor;
    
    //pass the competitor to the pdf manager
    pdfManager.strSelectedCompetitor = strSelectedCompetitor;
    
}

#pragma mark - Default Methods



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
