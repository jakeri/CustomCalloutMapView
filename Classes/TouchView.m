//
//  TouchView.m
//  
//
//  Created by Jakob Ericsson on 2009-09-23.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import "TouchView.h"

@interface TouchView ()
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
@end

@implementation TouchView
@synthesize delegate, callAtHitTest;


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

	
	UIView* returnMe =  [super hitTest:point withEvent:event];
	if (![returnMe isKindOfClass:[UIButton class]]) {
		[delegate performSelector:callAtHitTest];
	}

    return returnMe;
}




@end
