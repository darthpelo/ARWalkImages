//
//  ARWConnectionManagment.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 `ARWConnectionManagment` this class handles requests to download an image using Panoramio API:
 www.panoramio.com/map/get_panoramas.php?order=popularity&set=full&from=0&to=2&minx=%f&miny=%f&maxx=%f&maxy=%f&size=medium
 */
@interface ARWConnectionManagment : NSObject

+ (instancetype)sharedManager;

/**
 Sets a callback to be executed when the image is downloaded. The Panoramio API need max and min coordinates to search images insede 
 an area
 
 @param maxCoordinate The maximum coordinate
 @param minCoordinate The minimum coordinate
 @param success A block object to be executed when the download end succesfully. This block has no return value and takes a single argument which represents the image downloaded.
 @param failure A block object to be executed when the download end with error.
 */
- (void)getPhotoForLocation:(CLLocationCoordinate2D)maxCoordinate minCoordinate:(CLLocationCoordinate2D)minCoordinate success:(void(^)(UIImage *image))success failure:(void(^)())failure;

@end
