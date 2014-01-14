//
//  ARWCell.h
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARWCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *picImageView;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, weak) IBOutlet UILabel *locationInformationLabel;

@end
