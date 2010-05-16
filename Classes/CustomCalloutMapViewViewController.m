//
//  CustomCalloutMapViewViewController.m
//  CustomCalloutMapView
//
//  Created by Jakob Ericsson on 2009-11-01.
//  Copyright JAKERI AB 2009. All rights reserved.
//

#import "CustomCalloutMapViewViewController.h"
#import "MyAnnotationView.h"


@implementation CustomCalloutMapViewViewController

@synthesize mapView, touchView, moreInfoView;

NSString * const GMAP_ANNOTATION_SELECTED = @"gmapselected";

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	touchView.delegate = self;
	touchView.callAtHitTest = @selector(stopFollowLocation);
	
    //Next we create the MKMapView object, which will be added as a subview of viewTouch
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	mapView.delegate = self;
    [touchView addSubview:mapView];
	
    //And we display everything!
    [self.view addSubview:touchView];
	
	CLLocationCoordinate2D sweLoc = {63.048230,15.685730};
	MKCoordinateSpan sweSpan = MKCoordinateSpanMake(14.208889, 24.169922);
	MKCoordinateRegion sweRegion = MKCoordinateRegionMake(sweLoc, sweSpan);
	
	mapView.region = sweRegion;
	
	//Populate some test annotations.
	NSMutableArray* annotations = [[NSMutableArray alloc] init];
	CLLocationCoordinate2D coord2d = {59.33984880,18.11479872};
	MyAnnotation *anno = [[MyAnnotation alloc] initWithCoords:coord2d name:@"Somewhere"];
	[annotations addObject:anno];
	[anno release];
	
	CLLocationCoordinate2D coord2d1 = {65.80253606,21.67445822};
	MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoords:coord2d1 name:@"Nowhere"];
	[annotations addObject:anno1];
	[anno1 release];
	
	CLLocationCoordinate2D coord2d2 = {55.71919202,13.15571100};
	MyAnnotation *anno2 = [[MyAnnotation alloc] initWithCoords:coord2d2 name:@"Anywhere"];
	[annotations addObject:anno2];
	[anno2 release];
	
	[mapView addAnnotations:annotations];
	
	[annotations release];
	
	
	self.moreInfoView.frame = CGRectMake(20.0, 250.0  + 300.0, self.moreInfoView.frame.size.width, self.moreInfoView.frame.size.height);
	[self.touchView addSubview:self.moreInfoView];
}

- (void) stopFollowLocation {
	NSLog(@"stopFollowLocation called. Good place to put stop follow location annotation code.");
	
	//MyAnnotation* annotation;
	//for (annotation in mapView.annotations) {
		[mapView deselectAnnotation:selectedAnnotation animated:NO];
	//}
	
	[self hideAnnotation];
	
}

- (void) annotationClicked: (id <MKAnnotation>) annotation {
	MyAnnotation* ann = (MyAnnotation*) annotation;
	NSLog(@"Annotation clicked: %@", ann.name);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CustomCalloutMapView" message:[NSString stringWithFormat:@"You clicked at annotation: %@",ann.name] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	/*
	MKAnnotationView* annotationView = nil;
	
	MyAnnotation *myAnnotation = (MyAnnotation*) annotation;
	NSString* identifier = @"Pin";
	MKPinAnnotationView* annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if(nil == annView) {
		annView = [[[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier] autorelease];
	}
	
	[annView addObserver:self
			  forKeyPath:@"selected"
				 options:NSKeyValueObservingOptionNew
				 context:GMAP_ANNOTATION_SELECTED];
	
	[annView setPinColor:MKPinAnnotationColorGreen];
	
	CGPoint notNear = CGPointMake(10000.0,10000.0);
	annView.calloutOffset = notNear;
	annotationView = annView;
	
	[annotationView setEnabled:YES];
	[annotationView setCanShowCallout:YES];
	
	return annotationView;
	*/
	
	
	 MKAnnotationView* annotationView = nil;
	 
	 MyAnnotation *myAnnotation = (MyAnnotation*) annotation;
	 NSString* identifier = @"Pin";
	 MyAnnotationView* annView = (MyAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	 
	 if(nil == annView) {
	 annView = [[[MyAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier] autorelease];
	 }
	 
	 [annView addObserver:self
	 forKeyPath:@"selected"
	 options:NSKeyValueObservingOptionNew
	 context:GMAP_ANNOTATION_SELECTED];
	 
	 //[pin setPinColor:MKPinAnnotationColorGreen];
	 
	 annotationView = annView;
	 
	 [annotationView setEnabled:YES];
	 [annotationView setCanShowCallout:NO];
	 
	 return annotationView;
	 
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
	
    NSString *action = (NSString*)context;
	
    if([action isEqualToString:GMAP_ANNOTATION_SELECTED]){
		BOOL annotationAppeared = [[change valueForKey:@"new"] boolValue];
		if (annotationAppeared) {
			NSLog(@"annotation selected %@", ((MyAnnotationView*) object).annotation.title);
			[self showAnnotation:((MyAnnotationView*) object).annotation];
			selectedAnnotation = ((MyAnnotationView*) object).annotation;
			((MyAnnotationView*) object).image = [UIImage imageNamed:@"icon-sel.png"];
		}
		else {
			NSLog(@"annotation deselected %@", ((MyAnnotationView*) object).annotation.title);
			[self hideAnnotation];
			((MyAnnotationView*) object).image = [UIImage imageNamed:@"icon.png"];
		}
	}
}

- (void)showAnnotation:(MyAnnotation*)annotation {
	self.moreInfoView.text.text = annotation.title;
	[UIView beginAnimations: @"moveCNGCallout" context: nil];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	self.moreInfoView.frame = CGRectMake(10.0, 250.0, self.moreInfoView.frame.size.width, self.moreInfoView.frame.size.height);
	[UIView commitAnimations];	
	
}

- (void)hideAnnotation {
	self.moreInfoView.text.text = nil;
	[UIView beginAnimations: @"moveCNGCalloutOff" context: nil];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	self.moreInfoView.frame = CGRectMake(10.0, 250.0 + 300, self.moreInfoView.frame.size.width, self.moreInfoView.frame.size.height);
	[UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
