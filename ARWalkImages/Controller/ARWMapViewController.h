//
//  ARWMapViewController.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 18/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ARWMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *userPositionsList;

@end
