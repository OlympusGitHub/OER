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
#import "OAI_CheckBox.h"
#import "NSString-StripNonNumerics.h"
#import "OAI_View.h"


@interface ViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    OAI_Calculations* calculator;
    OAI_TitleBar* titleBarManager;
    OAI_ColorManager* colorManager;
    OAI_SplashScreen* appSplashScreen;
    OAI_FileManager* fileManager;
    OAI_TitleScreen* titleScreenManager;
    OAI_StringManager* stringManager;
    OAI_EmailSetup* vEmailManager;
    OAI_PDFManager* pdfManager;
    OAI_View* vMainView;
    
    
    UIScrollView* scNav;
    OAI_ScrollView* scSections;
    UISegmentedControl* scTopNav;
    UIView* vTableSection;
    
    UIFont* headerFont;
    UIFont* cellFont;
    
    UIColor* clrOlympusYellow;
    UIColor* clrDarkGrey;
    UIColor* clrLightGrey;
    
    NSMutableDictionary* dictTextFields;
    NSMutableDictionary* dictEstimatedUnitFields;
    NSMutableDictionary* dictEstimatedResults;
    NSMutableDictionary* dictResults;
    NSMutableDictionary* dictResultCells;
    NSMutableDictionary* dictInitialValues;
    NSMutableDictionary* dictTimeSavingNotes;
    NSMutableArray* arrResultHeaders;
    NSArray* arrTypes;
    NSArray* arrResultsTableHeaders;
    NSMutableDictionary* dictResultsData;
    NSArray* arrResultsRowHeaders;
    NSMutableArray* arrResultsRowHeaderLabels;
    NSMutableArray* arrResultsRowHeaderChecks;
    NSMutableArray* arrResultsRowCells; 
    NSArray* arrTimeSavingsRowHeaders;
    NSMutableDictionary* dictCompetitors;
    NSArray* arrCompetitorNames;
    NSArray* arrEmailCheckboxes;
    
    NSString* strFacilityName;
    
    UIView* vAccount;
    
    UIView* vCompChoices;
    float compViewHeight;
    UITableView* tblCompetitors;
    NSString* strSelectedCompetitor;
    
    NSString* strCurrentTextFieldValue;
    
    CGRect myKeyboardFrame;
    UITextField* myTextElement;
    CGPoint myScrollViewOrigiOffSet;
    
    BOOL hasItems;
    float competitionTotal;
    float aldaholTotal;
    float acedicdeTotal;
    
    float totalsALDAHOL;
    float totalsAcecideC;
    float totalsCompetition;
    
    float timeSavingsALDAHOLTotals;
    float timeSavingsAcedideCTotals;
    float timeSavingsCompetitionTotals;
    
    float aldaholTimeSavings;
    float aldaholStaffTimeSavings;
    float aldaholAnnualSavings;
    float acecideTimeSavings;
    float acecideStaffTimeSavings;
    float acecideAnnualSavings;
    
    BOOL isLandscape;
    int displayedPage;
    
    NSMutableString* strCostNote;
    
}

- (void) calculate : (NSString*) strCalculateWhat : (BOOL) isOpening;

- (void) calculateWithResults : (UIButton*) myButton;

- (void) calculateEstimates;

- (BOOL) checkStringValue : (NSString*) stringToCheck;

- (BOOL) validateEntries : (NSString*) validateWhat : (UITextField*) textField;

- (BOOL) validateThisEntry : (OAI_TextField*) textField;

- (void) showComparison : (UIButton*) myButton;

- (void) showEstimatedUnits;

- (void) showCalculations : (UIButton*) myButton;

- (NSString* ) convertToCurrencyString : (NSDecimalNumber*) numberToConvert;

- (void) getTimeSavings;

- (void) toggleEmailSetup : (UIButton*) myButton;

- (void) sendEmail;

- (void) showCompetitors : (UITapGestureRecognizer*) tgrMyTGR;

- (void) addCompetitorTimes;

- (void) setDiscount : (NSString*) strDiscount;

- (NSString*) convertToPercentage : (float) numberToConvert;

- (BOOL) checkDiscountValue : (NSString*) discountToCheck;

- (NSString*) stripDollarSign : (NSString*) stringToStrip;

- (NSString*) stripDecimalPoints : (NSString*) stringToStrip;

- (void) checkKeyboardConflict;

- (void) resetValues;

- (void) showResults : (NSDictionary*) dictResults;

- (void) dismissKeyboard;

- (void) resetComparisonDisplay : (NSString*) strThisRowHeader : (OAI_CheckBox*) thisCheckbox;

- (void) totalComparisons;

- (void) navOptions : (UISegmentedControl*) mySegmentedControl;

- (void) adjustResultsForOrientation : (UIView*) vResults;

- (void) adjustEstimatedForOritentation : (UIView*) vEstimated;

- (void) adjustCalculationsForOrientation : (UIView*) vInputs;





@end

