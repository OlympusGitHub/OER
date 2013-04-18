//
//  OAI_MessageBox.m
//  OER Pro Comparison
//
//  Created by Steve Suranie on 3/11/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_MessageBox.h"

@implementation OAI_MessageBox

@synthesize strErrMsg, strWarningSymbol;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        colorManager = [[OAI_ColorManager alloc] init];
        
        self.backgroundColor = [colorManager setColor:216 :236 :246];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = .75;
        self.layer.shadowOffset = CGSizeMake(-2.0, -2.0);
        
        //add close button

    }
    return self;
}

- (void) resetMessage {
    
    CGSize msgSize = [strErrMsg sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
    
    lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, msgSize.width, msgSize.height)];
    lblMsg.text = strErrMsg;
    lblMsg.textColor = [colorManager setColor:66.0 :66.0 :66.0];
    lblMsg.font =[UIFont fontWithName:@"Helvetica" size:18.0];
    lblMsg.backgroundColor = [UIColor clearColor];
    
    [self addSubview:lblMsg];

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
