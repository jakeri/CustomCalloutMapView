//
//  CustomCalloutMapViewAppDelegate.h
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright JAKERI AB 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCalloutMapViewViewController;

@interface CustomCalloutMapViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomCalloutMapViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CustomCalloutMapViewViewController *viewController;

@end

