//
//  OAI_TextField.h
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAI_ColorManager.h"

@interface OAI_TextField : UITextField <UITextFieldDelegate>{
    
    OAI_ColorManager* colorManager;
}

@property (nonatomic, retain) NSString* textFieldTitle;
@property (nonatomic, assign) int textFieldInputType;

@end
