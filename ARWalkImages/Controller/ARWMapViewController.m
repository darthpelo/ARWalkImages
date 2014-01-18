//
//  ARWMapViewController.m
//  ARWalkImages
//
//  Created by Alessio Roberto on 18/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import "ARWMapViewController.h"
#import "ARWPhoto.h"

@interface ARWMapViewController () {
    CLLocationCoordinate2D _userPosition;
}

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
    for (int i = 0; i < self.userPositionsList.count; i++) {
        // Add another annotation to the map.
        ARWPhoto *photo = [self.userPositionsList objectAtIndex:i];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = photo.photoLocation.coordinate;
        [self.mapView addAnnotation:annotation];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setUpMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpMap
{
    MKMapPoint annotationPoint = MKMapPointForCoordinate(_userPosition);
    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 2.0, 2.0);
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1.0, 1.0);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _userPosition = userLocation.coordinate;
}

@end
