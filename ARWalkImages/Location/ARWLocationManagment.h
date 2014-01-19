//
//  ARWLocationManagment.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "ARWPhoto.h"

@protocol ARWLocationManagmentDelegate <NSObject>
@required
/**
 Add new image to user walk history.
 
 @param photoObj An ARWPhoto istance with UIImage and coordinate of photo
 */
- (void)addNewPhoto:(ARWPhoto *)photoObj;
/**
 Add new user location to map, indipendent if there's an image
 */
- (void)addUserLocation:(CLLocation *)userLocation;
@end

/**
 `ARWLocationManagment` this class handles START and STOP images download
 */
@interface ARWLocationManagment : NSObject <CLLocationManagerDelegate>

@property (weak) id <ARWLocationManagmentDelegate> delegate;

+ (instancetype)sharedManager;

- (void)startMonitoringUserLocation;

- (void)stopMonitoringUserLocation;

@end
