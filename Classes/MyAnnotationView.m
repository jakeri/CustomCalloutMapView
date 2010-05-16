//
//  MyAnnotationView.m
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-12-03.
//  Copyright 2009 JAKERI AB. All rights reserved.
//

#import "MyAnnotationView.h"


@implementation MyAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	if (self != nil) {
		self.image  = [UIImage imageNamed:@"icon.png"];
		
		CGPoint notNear = CGPointMake(10000.0,10000.0);
		self.calloutOffset = notNear;

	}
	return self;
}

@end
