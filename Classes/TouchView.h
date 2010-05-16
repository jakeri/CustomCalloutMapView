//
//  TouchView.h
//
//  Created by Jakob Ericsson on 2009-09-23.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIView;

@interface TouchView : UIView {
	id delegate;
	SEL callAtHitTest;
}
@property (assign) id delegate;
@property (assign) SEL callAtHitTest;

@end
