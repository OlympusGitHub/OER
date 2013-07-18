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

- (void) adjustToRotation : (UIDeviceOrientation) orientation {
    
    CGRect parentBounds = CGRectMake(0.0, 0.0, 768.0, 1024.0);
    float imageY = 0.0;
    
    if (orientation == 1 || orientation == 2) {
        
        parentBounds.size.width = 768.0;
        parentBounds.size.height = 1024.0;
        imageY = 300.0;
        
    } else if (orientation == 3 || orientation == 4) {
        
        parentBounds.size.width = 1024.0;
        parentBounds.size.height = 768.0;
        imageY = 150.0;
    }
    
    //get cetner of width
    float parentCenter =  (parentBounds.size.width/2);
    
    
    //reset view
    [self setFrame:CGRectMake(0.0, 0.0, parentBounds.size.width, parentBounds.size.height)];
             
    //reset image
    [imgVOAILogo setFrame:CGRectMake(parentCenter-(imgVOAILogo.frame.size.width/2), imageY, imgVOAILogo.frame.size.width, imgVOAILogo.frame.size.height)];
    
    //reset title
    [OAIMDT setFrame:CGRectMake(parentCenter-(OAIMDT.frame.size.width/2), imgVOAILogo.frame.origin.y + 300.0, OAIMDT.frame.size.width, OAIMDT.frame.size.height)];
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
