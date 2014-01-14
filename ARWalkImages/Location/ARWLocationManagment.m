//
//  ARWLocationManagment.m
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <math.h>

#import "ARWLocationManagment.h"
#import "ARWConnectionManagment.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiandsToDegrees(x) (x * 180.0 / M_PI)

@interface ARWLocationManagment ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ARWLocationManagment

+ (instancetype)sharedManager {
    static ARWLocationManagment *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark Public Methods
- (void)startMonitoringUserLocation
{
    [self.locationManager startUpdatingLocation];
}

- (void)stopMonitoringUserLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark Private Properties

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 100;
    }
    return _locationManager;
}

#pragma mark - Private Methods
- (NSDictionary *)calculateBoundingCoordinates:(CLLocationCoordinate2D)coordinate
{
    double earthRadius = 6371; // earth radius in km
    double radius = 1; // square bounding box that is a given distance (e.g. 50km) away from the coordinate
    
    double x1 = coordinate.longitude - radiandsToDegrees(radius/earthRadius/cos(degreesToRadians(coordinate.latitude)));
    
    double x2 = coordinate.longitude + radiandsToDegrees(radius/earthRadius/cos(degreesToRadians(coordinate.latitude)));
    
    double y1 = coordinate.latitude + radiandsToDegrees(radius/earthRadius);
    
    double y2 = coordinate.latitude - radiandsToDegrees(radius/earthRadius);
    
    CLLocation *boundLocationMin = [[CLLocation alloc] initWithLatitude:y1 longitude:x1];
    CLLocation *boundLocationMax = [[CLLocation alloc] initWithLatitude:y2 longitude:x2];
    
    return @{
             @"min": boundLocationMin,
             @"max": boundLocationMax
             };
}

#pragma mark - CLLocation Manager Delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSDictionary *bound = [self calculateBoundingCoordinates:newLocation.coordinate];
    [[ARWConnectionManagment sharedManager] getPhotoForLocation:((CLLocation *)bound[@"max"]).coordinate minCoordinate:((CLLocation *)bound[@"min"]).coordinate success:^(UIImage *image) {
        ARWPhoto *newPhoto = [[ARWPhoto alloc] init];
        newPhoto.photo = image;
        newPhoto.photoLocation = newLocation;
        if ([self.delegate respondsToSelector:@selector(addNewPhoto:)]) {
            [self.delegate addNewPhoto:newPhoto];
        }
    } failure:^{
        NSLog(@"Error with query");
    }];
}

@end
