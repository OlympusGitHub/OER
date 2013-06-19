//
//  OAI_CheckBox.h
//  oer
//
//  Created by Steve Suranie on 6/17/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAI_CheckBox : UIImageView

@property (nonatomic, retain) NSString* strMyOperCostType;
@property (nonatomic, assign) BOOL isChecked;

- (void) toggleCheck : (UITapGestureRecognizer*) myTap; 


@end
