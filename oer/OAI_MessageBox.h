//
//  OAI_MessageBox.h
//  OER Pro Comparison
//
//  Created by Steve Suranie on 3/11/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "OAI_ColorManager.h"

@interface OAI_MessageBox : UIView {
    
    OAI_ColorManager* colorManager;
    
    UILabel* lblMsg;
}

@property (nonatomic, retain) NSString* strErrMsg;
@property (nonatomic, retain) NSString* strWarningSymbol;

- (void) resetMessage;


@end
