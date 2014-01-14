//
//  ARWViewController.m
//  ARWalkImages
//
//  Created by Alessio Roberto on 12/01/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import "ARWViewController.h"
#import "ARWLocationManagment.h"
#import "ARWCell.h"
#import "ARWPhoto.h"

@interface ARWViewController () {
    NSMutableArray *photosList;
    
    BOOL updating;
}

@end

@implementation ARWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    updating = NO;
    
    [[ARWLocationManagment sharedManager] setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(awakeFromBackgorund)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self awakeFromBackgorund];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)awakeFromBackgorund
{
    if (photosList)
        [self.tableView reloadData];
}

- (void)switchLocationUpdate:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (updating == YES) {
        [[ARWLocationManagment sharedManager] stopMonitoringUserLocation];
        updating = NO;
        [button setTitle:@"START" forState:UIControlStateNormal];
    } else {
        [[ARWLocationManagment sharedManager] startMonitoringUserLocation];
        updating = YES;
        [button setTitle:@"STOP" forState:UIControlStateNormal];
    }
}

#pragma mark - ARWLocation Managment delegate

- (void)addNewPhoto:(ARWPhoto *)photoObj
{
    if (photosList == nil) {
        photosList = [[NSMutableArray alloc] init];
    }
    [photosList insertObject:photoObj atIndex:0];
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
        [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return photosList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 60.0f)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(110, 10, 100, 45);
    if (updating == YES) {
        [button setTitle:@"STOP" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"START" forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(switchLocationUpdate:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
	return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ARWCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ARWCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.activityIndicator startAnimating];
    [cell.activityIndicator setHidden:NO];
    
    ARWPhoto *photoObj = [photosList objectAtIndex:indexPath.row];
    
    if (photoObj.photo) {
        [cell.activityIndicator stopAnimating];
        [cell.activityIndicator setHidden:YES];
        cell.picImageView.image = photoObj.photo;
    } else {
        cell.picImageView = nil;
    }
    
    return cell;
}

@end
