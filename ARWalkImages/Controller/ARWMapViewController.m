//
//  ARWMapViewController.m
//  ARWalkImages
//
//  Created by Alessio Roberto on 18/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import "ARWMapViewController.h"
#import "ARWPhoto.h"

@interface ARWMapViewController ()

@end

@implementation ARWMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (int i = 0; i < self.photosList.count; i++) {
        // Add another annotation to the map.
        ARWPhoto *photo = [self.photosList objectAtIndex:i];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = photo.photoLocation.coordinate;
        [self.mapView addAnnotation:annotation];
    }
    [self setUpMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpMap
{
    MKMapPoint annotationPoint = MKMapPointForCoordinate(self.mapView.userLocation.coordinate);
    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1.0, 1.0);
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1.0, 1.0);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
}

@end
