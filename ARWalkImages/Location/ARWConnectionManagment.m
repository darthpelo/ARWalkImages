//
//  ARWConnectionManagment.m
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import "ARWConnectionManagment.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation ARWConnectionManagment

+ (instancetype)sharedManager {
    static ARWConnectionManagment *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (void)getPhotoForLocation:(CLLocationCoordinate2D)maxCoordinate minCoordinate:(CLLocationCoordinate2D)minCoordinate success:(void(^)(UIImage *image))success failure:(void(^)())failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //www.panoramio.com/map/get_panoramas.php?order=popularity&set=full&from=80&to=100&minx=-7.47&miny=42.29&maxx=-7.42&maxy=42.32&size=medium
    NSString *urlStr = [NSString stringWithFormat:@"http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=full&from=0&to=2&minx=%f&miny=%f&maxx=%f&maxy=%f&size=medium", minCoordinate.longitude, minCoordinate.latitude, maxCoordinate.longitude, maxCoordinate.latitude];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"%@ - %@", urlStr, responseObject);
#endif
        NSArray *photos = responseObject[@"photos"];
        if(photos.count == 0) {
            failure();
        } else {
            NSDictionary *photo = [photos objectAtIndex:0];
            
            UIImageView *tmp = [[UIImageView alloc] init];
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:photo[@"photo_file_url"]]
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:10.0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tmp setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    success(image);
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure();
                }];
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

@end
