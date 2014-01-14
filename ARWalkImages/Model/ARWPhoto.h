//
//  ARWPhoto.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ARWPhoto : NSObject

@property (nonatomic, strong) CLLocation *photoLocation;

@property (nonatomic, strong) UIImage *photo;

@end
