//
//  OAI_SplashScreen.m
//  OAI_IntegrationSiteReport_v1
//
//  Created by Steve Suranie on 11/14/12.
//  Copyright (c) 2012 Steve Suranie. All rights reserved.
//

#import "OAI_SplashScreen.h"

@implementation OAI_SplashScreen

@synthesize parentView, myTitleScreen;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        colorManager = [[OAI_ColorManager alloc] init];
        fileManager = [[OAI_FileManager alloc] init];
        
        //get version number
        NSDictionary* dictAppInfo = [[NSBundle mainBundle] infoDictionary];
        strVersion = [dictAppInfo objectForKey:@"CFBundleShortVersionString"];
        
        
    }
    return self;
}

- (void) runSplashScreenAnimation {
    
    
    //reset the splash screen frame to the bounds of the main window
    parentView = self.superview;
    CGRect parentBounds = parentView.bounds;
    
    //set the background to white
    self.backgroundColor = [UIColor whiteColor];
    
    //load the logo
    UIImage* logoImage = [UIImage imageNamed:@"OA_img_logo_iPadOptimized"];
    imgVOAILogo = [[UIImageView alloc] initWithImage:logoImage];
                                
    //reset the image to the center of the window
    CGRect logoFrame = imgVOAILogo.frame;
    logoFrame.origin.x = (parentBounds.size.width/2)-(logoFrame.size.width/2);
    logoFrame.origin.y = 300.0;
    imgVOAILogo.frame = logoFrame;
    
    //add the OMDT title
    OAIMDT_title = @"Olympus Mobile Development Team";
    CGSize titleSize = [OAIMDT_title sizeWithFont:[UIFont fontWithName:@"Helvetica" size:24.0]];
    float labelX = (parentBounds.size.width/2) - (titleSize.width/2);
    float labelY = logoFrame.origin.y + 300.0;
    
    OAIMDT = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, titleSize.width, titleSize.height)];
    OAIMDT.text = OAIMDT_title;
    OAIMDT.backgroundColor = [UIColor clearColor];
    OAIMDT.textColor = [colorManager setColor:8.0 :16.0 :123.0];
    OAIMDT.font = [UIFont fontWithName:@"Helvetica" size:24.0];
    
    
    //add objects to self and parent view
    [self addSubview:imgVOAILogo];
    [self addSubview:OAIMDT];
    
    //get audio file
    olympusSoundURL = [[NSBundle mainBundle] URLForResource:@"OLYMPUS_SL_MST" withExtension:@"mp3"];
    NSError* error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:olympusSoundURL error:&error];
    audioPlayer.volume = .5;
    
    NSString* strVersionTitle = [NSString stringWithFormat:@"Version %@", strVersion];
    CGSize versionTitleSize = [strVersionTitle sizeWithFont:[UIFont fontWithName:@"Helvetica" size:10.0] constrainedToSize:CGSizeMake(100.0, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel* lblVersionNum = [[UILabel alloc] initWithFrame:CGRectMake(labelX + ((titleSize.width*2)-versionTitleSize.width), OAIMDT.frame.origin.y + OAIMDT.frame.size.height + 10.0, 100.0, 30.0)];
    lblVersionNum.text = strVersionTitle;
    lblVersionNum.textColor = [colorManager setColor:66.0 :66.0 :66.0];
    lblVersionNum.backgroundColor = [UIColor clearColor];
    lblVersionNum.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    lblVersionNum.tag = 101;
    [self addSubview:lblVersionNum];
    
    
    //fade
    [UIView animateWithDuration:3 delay:1.0 options:UIViewAnimationOptionCurveEaseOut
     
        animations:^{
            [audioPlayer play];
            self.alpha = 0.0;
        }
     
        completion:^ (BOOL finished) {
                        
            //reset the splash screen to be off stage so as not to interfer with gestures
            CGRect selfFrame = self.frame;
            selfFrame.origin.x = 0-selfFrame.origin.x;
            selfFrame.origin.y = 0-selfFrame.origin.y;
            self.frame = selfFrame;
            
            //fade the title screen after the splash screen has faded 
            [myTitleScreen fadeTitleScreen];
            
        }
     ];
    
    
    
    
    
}

- (void) adjustForRotation : (UIDeviceOrientation) orientation {
    
    //get subviews
    NSArray* arrMySubviews = self.subviews;
    UIImageView* ivLogo;
    UILabel* lblTitle;
    UILabel* lblVersion;
    
    for(int i=0; i<arrMySubviews.count; i++) {
        
        if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UIImageView class]]) {
            ivLogo = [arrMySubviews objectAtIndex:i];
        } else if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UILabel class]]) {
            UILabel* thisLabel = [arrMySubviews objectAtIndex:i];
            
            if (thisLabel.tag == 101) {
                lblVersion = thisLabel;
            } else {
                lblTitle = thisLabel;
            }
        }
    }
    
    //rotate the view
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
        
    } else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 768.0, 1024.0)];
        
    }
    
    CGRect myFrame = self.frame;
    
    //center the logo
    CGRect myLogoFrame = ivLogo.frame;
    myLogoFrame.origin.x = (myFrame.size.width/2)-(myLogoFrame.size.width/2);
    
    ivLogo.frame = myLogoFrame;
    
    //center the title
    CGRect myTitleFrame = lblTitle.frame;
    myTitleFrame.origin.x = (myFrame.size.width/2)-(myTitleFrame.size.width/2);
    
    lblTitle.frame = myTitleFrame;
    
    //reset version number label
    CGRect myVersionFrame = lblVersion.frame;
    myVersionFrame.origin.x = ((self.frame.size.width/2) - (myTitleFrame.size.width/2)) + myTitleFrame.size.width-myVersionFrame.size.width;
    lblVersion.frame = myVersionFrame;
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
