//
//  OAI_CheckBox.m
//  oer
//
//  Created by Steve Suranie on 6/17/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_CheckBox.h"

@implementation OAI_CheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(toggleCheck:)];
        
        [self addGestureRecognizer:tap];
        [self setImage:[UIImage imageNamed:@"btnRadioOn.png"]];
    }
    return self;
}

- (void) toggleCheck : (UITapGestureRecognizer*) myTap {
    
    if (_isChecked) {
        
        //turn it off
        [self setImage:[UIImage imageNamed:@"btnRadioOff.png"]];
        _isChecked = NO;
    
    } else {
        
        [self setImage:[UIImage imageNamed:@"btnRadioOn.png"]];
        _isChecked = YES;
        
    }
    
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    
    [userData setObject:@"Checkbox Toggle" forKey:@"Action"];
    [userData setObject:_strMyOperCostType  forKey:@"Row Header"];
    [userData setObject:self forKey:@"Checkbox"];
    
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
