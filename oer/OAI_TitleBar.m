//
//  OAI_TitleBar.m
//  AVI Site Integration
//
//  Created by Steve Suranie on 3/7/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_TitleBar.h"

@implementation OAI_TitleBar

@synthesize titleBarTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        //shadow
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.75;
        
        titleFont = [UIFont fontWithName:@"Helvetica" size:22.0];
        
    }
    return self;
}

#pragma mark - Adjust For Orientation Methods
- (void) adjustForRotation : (UIDeviceOrientation) orientation {
    
    //get the subviews
    NSArray* arrMySubviews = self.subviews;
    
    //get the label
    UILabel* lblTitleLabel;
    for(int i=0; i<arrMySubviews.count; i++) {
        if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UILabel class]]) {
            lblTitleLabel = [arrMySubviews objectAtIndex:i];
        }
    }
    
    //get the size of the title
    CGSize myTitleSize = [lblTitle.text sizeWithFont:titleFont constrainedToSize:CGSizeMake(self.frame.size.width, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 1024.0, 50.0)];
        
    } else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 768.0, 50.0)];
        
    }
    
    CGRect titleFrame = lblTitleLabel.frame;
    
    //reposition app title
    titleFrame.origin.x = self.frame.size.width - (myTitleSize.width + 30.0);
    lblTitleLabel.frame = titleFrame;
}


- (void) buildTitleBar {
        
    //set olympus logo
    UIImageView* OALogoTopBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OA_logo_black_topbar.png"]];
    
    //position the logo
    CGRect topBarLogoFrame = OALogoTopBar.frame;
    topBarLogoFrame.origin.x = 15.0;
    topBarLogoFrame.origin.y = 8.0;
    OALogoTopBar.frame = topBarLogoFrame;
    
    //add the logo
    [self addSubview:OALogoTopBar];
    
    //add the toggle account data button
    UIImage* imgAccount = [UIImage imageNamed:@"btnAccount.png"];
    UIButton* btnAccount = [[UIButton alloc] initWithFrame:CGRectMake(OALogoTopBar.frame.origin.x+OALogoTopBar.frame.size.width + 20.0, 4.0, imgAccount.size.width, imgAccount.size.height)];
    [btnAccount setImage:imgAccount forState:UIControlStateNormal];
    [btnAccount addTarget:self action:@selector(toggleAccount:) forControlEvents:UIControlEventTouchUpInside];
    [btnAccount setBackgroundColor:[UIColor clearColor]];
    [self addSubview:btnAccount];
    
    //add the reset data button
    UIImage* imgReset = [UIImage imageNamed:@"btnReload.png"];
    UIButton* btnReset = [[UIButton alloc] initWithFrame:CGRectMake(btnAccount.frame.origin.x+btnAccount.frame.size.width + 20.0, 2.0, imgReset.size.width, imgReset.size.height)];
    [btnReset setImage:imgReset forState:UIControlStateNormal];
    [btnReset addTarget:self action:@selector(resetAll:) forControlEvents:UIControlEventTouchUpInside];
    [btnReset setBackgroundColor:[UIColor clearColor]];
    [self addSubview:btnReset];

    
    //add title bar title
    CGSize titleSize = [titleBarTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
    
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(titleSize.width+10.), 8.0, titleSize.width, titleSize.height)];
    lblTitle.text = titleBarTitle;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    [self addSubview:lblTitle];

    
}

- (void) toggleAccount : (UIButton* ) btnAccount {
    
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    
    [userData setObject:@"Show Account" forKey:@"Action"];
    
    /*This is the call back to the notification center, */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];
    
}

- (void) resetAll : (UIButton*) myButton {
    
    //return dictionary of results
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    [userData setObject:@"Reset All" forKey:@"Action"];
    
    /*This is the call back to the notification center, */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];
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
