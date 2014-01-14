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
- (void)addNewPhoto:(ARWPhoto *)photoObj;

@end

@interface ARWLocationManagment : NSObject <CLLocationManagerDelegate>

@property (weak) id <ARWLocationManagmentDelegate> delegate;

+ (instancetype)sharedManager;

- (void)startMonitoringUserLocation;

- (void)stopMonitoringUserLocation;

@end
