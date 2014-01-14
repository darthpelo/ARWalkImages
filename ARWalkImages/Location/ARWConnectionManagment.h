//
//  ARWConnectionManagment.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ARWConnectionManagment : NSObject

+ (instancetype)sharedManager;

- (void)getPhotoForLocation:(CLLocationCoordinate2D)maxCoordinate minCoordinate:(CLLocationCoordinate2D)minCoordinate success:(void(^)(UIImage *image))success failure:(void(^)())failure;

@end
