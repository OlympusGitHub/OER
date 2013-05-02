//
//  OAI_EmailSetup.h
//  OER
//
//  Created by Steve Suranie on 4/8/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "OAI_ColorManager.h"
#import "OAI_Label.h"
#import "OAI_SimpleCheckbox.h"

@interface OAI_EmailSetup : UIView {
    
    OAI_ColorManager* colorManager;
    
    //objects
    UITextField* txtFacility;
    
    
}

@property (nonatomic, retain) NSString* strSelectedCompetitor;
@property (nonatomic, retain) NSMutableArray* arrMyCheckboxes;

- (void) sendEmail : (UIButton*) myButton;

- (void) closeWin : (UIButton*) myButton;

@end
