//
//  OAI_EmailSetup.m
//  OER
//
//  Created by Steve Suranie on 4/8/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_EmailSetup.h"

@implementation OAI_EmailSetup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        colorManager = [[OAI_ColorManager alloc] init];
        
        _arrMyCheckboxes = [[NSMutableArray alloc] init];
        
        /*************************************
         EMAIL SETUP SCREEN
         *************************************/
        
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowRadius:3.0];
        [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        //title bar
        UIView* vLblBG = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 40.0)];
        vLblBG.backgroundColor = [colorManager setColor:8 :16 :123];
        
        NSString* strEmailOptionsTitle=  @"Email Options";
        CGSize emailOptionsTitleSize = [strEmailOptionsTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:24.0]];
        
        OAI_Label* lblEmailOptions = [[OAI_Label alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(emailOptionsTitleSize.width/2), 10.0, emailOptionsTitleSize.width+ 100.0, 30.0)];
        lblEmailOptions.text = strEmailOptionsTitle;
        lblEmailOptions.textColor = [UIColor whiteColor];
        lblEmailOptions.backgroundColor = [UIColor clearColor];
        lblEmailOptions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
        [vLblBG addSubview:lblEmailOptions];
        
        [self addSubview:vLblBG];
        
        //add any specific email instructions for this app here
        NSString* strMailInstructions = @"Enter the name of the facility you are sending these results to in the text field below.";
        
        UILabel* lblMailInstructions = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-250.0, vLblBG.frame.origin.y + vLblBG.frame.size.height + 20.0, 500.0, 40.0)];
        lblMailInstructions.text = strMailInstructions;
        lblMailInstructions.textColor = [colorManager setColor:66.0 :66.0 :66.0];
        lblMailInstructions.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        lblMailInstructions.numberOfLines = 0;
        lblMailInstructions.lineBreakMode  = NSLineBreakByWordWrapping;
        lblMailInstructions.backgroundColor = [UIColor clearColor];
        lblMailInstructions.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lblMailInstructions];
        
        /*
         //recipient name
         NSString* strName=  @"Recipeint Name";
         
         txtName = [[UITextField alloc] initWithFrame:CGRectMake((vMailOptions.frame.size.width/2)-250.0, vLblBG.frame.origin.y + vLblBG.frame.size.height + 30.0, 500.0, 40.0)];
         txtName.textColor = [colorManager setColor:66.0:66.0:66.];
         txtName.backgroundColor = [UIColor whiteColor];
         txtName.borderStyle = UITextBorderStyleRoundedRect;
         txtName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
         txtName.placeholder = strName;
         [vMailOptions addSubview:txtName];
         */
        
        //company name
        NSString* strFacility = @"Company/Facility Name";
        
        txtFacility = [[UITextField alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-250.0, lblMailInstructions.frame.origin.y + lblMailInstructions.frame.size.height + 20.0, 500.0, 40.0)];
        txtFacility.textColor = [colorManager setColor:66.0:66.0:66.];
        txtFacility.backgroundColor = [UIColor whiteColor];
        txtFacility.borderStyle = UITextBorderStyleRoundedRect;
        txtFacility.placeholder = strFacility;
        txtFacility.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        [self addSubview:txtFacility];
        
        /*NSString* strPDFOption=  @"Attach PDF?";
        CGSize PDFOptionSize = [strPDFOption sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:24.0]];
        
        //pdf options label
        
        OAI_Label* lblPDFOption = [[OAI_Label alloc] initWithFrame:CGRectMake((vMailOptions.frame.size.width/2)-(PDFOptionSize.width/2), txtFacility.frame.origin.y + txtFacility.frame.size.height, PDFOptionSize.width, 60.0)];
        lblPDFOption.text = strPDFOption;
        lblPDFOption.textColor = [colorManager setColor:66.0 :66.0 :66.0];
        lblPDFOption.backgroundColor = [UIColor clearColor];
        [self addSubview:lblPDFOption];
         
        
        //our sc butttons
        NSArray* segmentedControlItems = [[NSArray alloc] initWithObjects:@"Yes", @"No", nil];
        
        //pdf  options
        scPDFOptions = [[UISegmentedControl alloc] initWithItems:segmentedControlItems];
        //reset
        CGRect scPDFOptionsFrame = scPDFOptions.frame;
        scPDFOptionsFrame.origin.x = ((self/2)-(scPDFOptionsFrame.size.width/2));
        scPDFOptionsFrame.origin.y = lblPDFOption.frame.origin.y + lblPDFOption.frame.size.height + 5.0;
        scPDFOptions.frame = scPDFOptionsFrame;
        scPDFOptions.selectedSegmentIndex = 0;
        
        [self addSubview:scPDFOptions];
         */
        
        UIView* vCheckBoxMatrix = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-250.0, txtFacility.frame.origin.y + txtFacility.frame.size.height + 10.0, 500.0, 80.0)];
        
        NSString* strCheckboxInst = @"Check which information you wish to send to the client.";
        CGSize checkboxInstSize = [strCheckboxInst sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20.0]];
        
        OAI_Label* lblCheckboxInst = [[OAI_Label alloc] initWithFrame:CGRectMake((vCheckBoxMatrix.frame.size.width/2)-(checkboxInstSize.width/2), 0.0, checkboxInstSize.width, 30.0)];
        lblCheckboxInst.text = strCheckboxInst;
        lblCheckboxInst.textColor = [colorManager setColor:66.0 :66.0 :66.0];
        lblCheckboxInst.backgroundColor = [UIColor clearColor];
        lblCheckboxInst.textAlignment = NSTextAlignmentCenter;
        [vCheckBoxMatrix addSubview:lblCheckboxInst];
        
        NSArray* arrCheckboxLabels = [[NSArray alloc] initWithObjects:@"ALDAHOL", @"Acecide-C", @"Competitor", nil];
        
        float checkX = 10.0;
        float checkY = lblCheckboxInst.frame.origin.y + lblCheckboxInst.frame.size.height + 10.0;
        float checkW = 30.0;
        float checkH = 30.0;
        for(int i=0; i<arrCheckboxLabels.count; i++) {
            
            NSString* strCheckLabel = [arrCheckboxLabels objectAtIndex:i];
            CGSize checkLabelSize = [strCheckLabel sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20.0]];
            
            OAI_SimpleCheckbox* ckThisBox = [[OAI_SimpleCheckbox alloc] initWithFrame:CGRectMake(checkX, checkY, checkW, checkH)];
            ckThisBox.elementID = [arrCheckboxLabels objectAtIndex:i];
            ckThisBox.isChecked = @"NO";
            [ckThisBox buildCheckBox];
            
            [vCheckBoxMatrix addSubview:ckThisBox];
            
            //add the check box label
            
            //check to see if a competitor was selected
            
            
            UILabel* lblCheckBox = [[UILabel alloc] initWithFrame:CGRectMake(ckThisBox.frame.origin.x + 35.0, checkY, checkLabelSize.width, 30.0)];
            lblCheckBox.text = strCheckLabel;
            lblCheckBox.textColor = [colorManager setColor:66.0 :66.0 :66.0];
            lblCheckBox.backgroundColor = [UIColor clearColor];
            [vCheckBoxMatrix addSubview:lblCheckBox];
            
            if (i==arrCheckboxLabels.count-1) {
                lblCheckBox.tag = 200;
            }
            
            checkX = checkX + 140.0;
            
            //add checkbox to array of elements
            [_arrMyCheckboxes addObject:ckThisBox];
            
        }
        
        [self addSubview:vCheckBoxMatrix];
        
        
        //buttons
        //submit images
        UIImage* imgSubmitNormal = [UIImage imageNamed:@"btnSubmitNormal.png"];
        UIImage* imgSubmitHighlight = [UIImage imageNamed:@"btnSubmitHighlight.png"];
        
        //get the image sizes
        CGSize imgSubmitNormalSize = imgSubmitNormal.size;
        
        UIButton* btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSubmit setImage:imgSubmitNormal forState:UIControlStateNormal];
        [btnSubmit setImage:imgSubmitHighlight forState:UIControlStateHighlighted];
        
        //reset the button frame
        CGRect btnSubmitFrame = btnSubmit.frame;
        btnSubmitFrame.origin.x = (self.frame.size.width/2)-(imgSubmitNormalSize.width+5);
        btnSubmitFrame.origin.y = (vCheckBoxMatrix.frame.origin.y + vCheckBoxMatrix.frame.size.height) + 30.0;
        btnSubmitFrame.size.width = imgSubmitNormalSize.width;
        btnSubmitFrame.size.height = imgSubmitNormalSize.height;
        btnSubmit.frame = btnSubmitFrame;
        
        //add the action
        [btnSubmit addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
        //a tag so we can identify it
        btnSubmit.tag = 101;
        [self addSubview:btnSubmit];
        
        //submit images
        UIImage* imgCancelNormal = [UIImage imageNamed:@"btnCancelNormal.png"];
        UIImage* imgCancelHighlight = [UIImage imageNamed:@"btnCancelHighlight.png"];
        
        UIButton* btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancel setImage:imgCancelNormal forState:UIControlStateNormal];
        [btnCancel setImage:imgCancelHighlight forState:UIControlStateHighlighted];
        
        //reset the button frame
        CGRect btnCancelFrame = btnCancel.frame;
        btnCancelFrame.origin.x = (self.frame.size.width/2);
        btnCancelFrame.origin.y = (vCheckBoxMatrix.frame.origin.y + vCheckBoxMatrix.frame.size.height) + 30.0;
        btnCancelFrame.size.width = imgSubmitNormalSize.width;
        btnCancelFrame.size.height = imgSubmitNormalSize.height;
        btnCancel.frame = btnCancelFrame;
        
        //add the action
        [btnCancel addTarget:self action:@selector(closeWin:) forControlEvents:UIControlEventTouchUpInside];
        //a tag so we can identify it
        btnCancel.tag = 102;
        [self addSubview:btnCancel];
        
        UIView* vMailBand = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height-20.0, self.frame.size.width, 20.0)];
        vMailBand.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"mailBand.png"]];
        [self addSubview:vMailBand];
        
    }
    return self;
}

- (void) sendEmail:(UIButton *)myButton {
    
    //set up ivars
    NSString* strThisFacility = txtFacility.text;
    BOOL hasError = NO;
    NSMutableArray* arrShowItems = [[NSMutableArray alloc] init];
    NSMutableString* strErrMsg = [[NSMutableString alloc] initWithString:@"There was an error with your email setup, please correct the following:"];
    
    //check to see if a facility name has been entered
    if (strThisFacility.length == 0 || strThisFacility == nil) {
        hasError = YES;
        [strErrMsg appendString:@"\n\nYou must enter a facility name."];
    }
    
    //check to see if any items have been checked
    int checkedItems = 0;
    for(int i=0; i<_arrMyCheckboxes.count; i++) {
        
        OAI_SimpleCheckbox* thisCheckbox = [_arrMyCheckboxes objectAtIndex:i];
        if ([thisCheckbox.isChecked isEqualToString:@"YES"])  {
            checkedItems = checkedItems + 1;
            [arrShowItems addObject:thisCheckbox];
        }
    }
             
    if (checkedItems == 0) {
        hasError = YES;
        [strErrMsg appendString:@"\n\nYou must check at least one item to include in the email."];
    }
    
    //if there is no error, submit the data
    if (!hasError) { 
    
        //call back to the notification center so we can fire up the email
        NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
        
        [userData setObject:@"Send Email" forKey:@"Action"];
        [userData setObject:arrShowItems forKey:@"Items To Show"];
        [userData setObject:strThisFacility forKey:@"Facility Name"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];
    
    } else { 
   
        UIAlertView *alert = [[UIAlertView alloc]
          initWithTitle: @"Email Submission Error!"
          message: strErrMsg
          delegate: nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil];
        [alert show];
    }

}

- (void) closeWin:(UIButton*) myButton {
    
    CGRect selfFrame = self.frame;
    selfFrame.origin.y = 0.0-selfFrame.size.height;
    
    [UIView animateWithDuration:0.4
     animations:^{
         
         self.frame = selfFrame;
         
     }
     
     completion:^(BOOL finished){
         nil;
     }
     
    ];
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
