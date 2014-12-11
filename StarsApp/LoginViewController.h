//
//  LoginViewController.h
//  FIUStars
//
//  Created by robert jose gomez on 11/30/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentViewController.h"
#import <CoreData/CoreData.h>
#import "User.h"
#import "UserViewController.h"



@interface LoginViewController : UIViewController <NSFetchedResultsControllerDelegate>

//declare properties
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) NSMutableArray* users;
@property (strong, nonatomic) NSMutableArray* allAppointments;
@property (strong,nonatomic) User *currentUser;

//new user button action
- (IBAction)btnNewAccount:(id)sender;

//login button action
- (IBAction)btnLogin:(id)sender;
//property for login
@property (weak, nonatomic) IBOutlet UITextField *txtLogin;




@end
