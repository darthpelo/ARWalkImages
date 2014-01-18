//
//  ARWViewController.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARWLocationManagment.h"

@interface ARWViewController : UITableViewController <ARWLocationManagmentDelegate>

- (IBAction)pushMapViewController:(id)sender;

@end
