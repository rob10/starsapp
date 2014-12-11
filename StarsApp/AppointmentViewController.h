//
//  AppointmentViewController.h
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "User.h"
#import "UserViewController.h"
#import "MiscViewController.h"

@interface AppointmentViewController : UITableViewController

//Declare properties for Appointments controller
@property(strong,nonatomic)User *currentUser2;
@property(strong, nonatomic)NSManagedObjectContext *context2;
- (IBAction)newAppointment:(id)sender;
@property (strong, nonatomic)NSMutableArray *allAppts;

@end
