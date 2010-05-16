//
//  CustomCalloutMapViewViewController.h
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright JAKERI AB 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TouchView.h"
#import "MyAnnotation.h"
#import "MoreInfoView.h"

@interface CustomCalloutMapViewViewController : UIViewController<MKMapViewDelegate> {

	MKMapView *mapView;
	TouchView* touchView;
	IBOutlet MoreInfoView* moreInfoView;
	MyAnnotation *selectedAnnotation;
	
}

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) TouchView* touchView;
@property (retain) IBOutlet MoreInfoView* moreInfoView;
extern NSString *const GMAP_ANNOTATION_SELECTED;

- (void) showAnnotation:(MyAnnotation*) annotation;
- (void) hideAnnotation;
@end

