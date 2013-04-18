//
//  ViewController.h
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

#import "OAI_Calculations.h"
#import "OAI_TitleBar.h"
#import "OAI_ColorManager.h"
#import "OAI_FileManager.h"
#import "OAI_SplashScreen.h"
#import "OAI_TitleScreen.h"
#import "OAI_StringManager.h"
#import "OAI_BarChart.h"
#import "OAI_EmailSetup.h"
#import "OAI_PDFManager.h"

#import "OAI_TextField.h"
#import "OAI_Label.h"
#import "OAI_ScrollView.h"
#import "NSString-StripNonNumerics.h"


@interface ViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>{
    
    OAI_Calculations* calculator;
    OAI_TitleBar* titleBarManager;
    OAI_ColorManager* colorManager;
    OAI_SplashScreen* appSplashScreen;
    OAI_FileManager* fileManager;
    OAI_TitleScreen* titleScreenManager;
    OAI_StringManager* stringManager;
    OAI_EmailSetup* vEmailManager;
    OAI_PDFManager* pdfManager;
    
    
    UIScrollView* scNav;
    
    UIFont* headerFont;
    UIFont* cellFont;
    
    UIColor* clrOlympusYellow;
    UIColor* clrDarkGrey;
    UIColor* clrLightGrey;
    
    NSMutableDictionary* dictTextFields;
    NSMutableDictionary* dictResults;
    NSMutableDictionary* dictResultCells;
    NSArray* arrTypes;
    NSArray* arrResultsTableHeaders;
    NSMutableDictionary* arrResultsData;
    NSArray* arrResultsRowHeaders;
    NSArray* arrTimeSavingsRowHeaders;
    
    NSString* strFacilityName;
    
    UIView* vAccount;
    
}

- (void) calculate;

- (void) calculateWithResults : (UIButton*) myButton;

- (BOOL) checkStringValue : (NSString*) stringToCheck;

- (BOOL) validateEntries : (NSString*) validateWhat;

- (BOOL) validateThisEntry : (OAI_TextField*) textField;

- (void) showComparison : (UIButton*) myButton;

- (void) showCalculations : (UIButton*) myButton;

- (NSString* ) convertToCurrencyString : (float) numToConvert;

- (UIView*) getTimeSavings : (UIScrollView*) parentScroll;

- (void) toggleEmailSetup : (UIButton*) myButton;

- (void) sendEmail;



@end

