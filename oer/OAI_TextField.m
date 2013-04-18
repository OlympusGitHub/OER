//
//  OAI_TextField.m
//  OER
//
//  Created by Steve Suranie on 3/26/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_TextField.h"

@implementation OAI_TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        
        colorManager = [[OAI_ColorManager alloc] init];
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.textColor = [colorManager setColor: 66.0:66.0:66.0];
        self.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        self.userInteractionEnabled = YES;
    }
    return self;
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
