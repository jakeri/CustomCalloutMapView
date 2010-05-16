//
//  CustomCalloutMapViewAppDelegate.m
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright JAKERI AB 2009. All rights reserved.
//

#import "CustomCalloutMapViewAppDelegate.h"
#import "CustomCalloutMapViewViewController.h"

@implementation CustomCalloutMapViewAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
