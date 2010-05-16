//
//  MyAnnotation.m
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate, name, title;

- (id) initWithCoords:(CLLocationCoordinate2D) coords name:(NSString*) inputName {
	
	self = [super init];
	if (self != nil) {
		coordinate = coords;
		self.name = inputName;
		self.title = inputName;
	}
	return self;
	
}
@end
