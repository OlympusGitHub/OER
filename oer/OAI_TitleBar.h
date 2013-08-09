//
//  OAI_TitleBar.h
//  AVI Site Integration
//
//  Created by Steve Suranie on 3/7/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OAI_TitleBar : UIView {
    
    UILabel* lblTitle;
    UIFont* titleFont;
    
}

@property (nonatomic, retain) NSString* titleBarTitle;

- (void) buildTitleBar;

- (void) adjustForRotation : (UIDeviceOrientation) orientation;

- (void) toggleAccount : (UIButton* ) btnAccount;

- (void) resetAll : (UIButton*) myButton;

@end
