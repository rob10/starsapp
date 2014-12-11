//
//  AppointmentViewController.m
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "AppointmentViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

@synthesize currentUser2, context2, allAppts;

//Like in the logincontroller this is used to handle the managedobject with the database
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//

//Changes the title for the tabs on the tabcontroller
- (void)viewDidLoad
{
    AppointmentViewController *ac = [self.navigationController.viewControllers objectAtIndex:0];
    
    ac.navigationItem.title = @"Sign out";
    //self.navigationItem.hidesBackButton = YES;
    
    //instatiate singleton instance of User
    currentUser2 = [User sharedDB];
    UserViewController *uv = [self.tabBarController.viewControllers objectAtIndex:1];
    MiscViewController *mv = [self.tabBarController.viewControllers objectAtIndex:2];
    
    self.title = @"Appointmemts";
    uv.title = @"User";
    mv.title = @"Feedback";
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Appointments"];
    self.allAppts = [[context executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//reloads the tableview every time the view appears
-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


//returns the number of appointments in the user appointments array
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    
    return [currentUser2.appointments count];
    
}

//Edits every cell with the values from every appointment
#pragma mark -
#pragma mark Table Data Source Methods
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *NameListIdentifier =
	@"NameListIdentifier";
	
    UITableViewCell *cell = [tableView
							 dequeueReusableCellWithIdentifier:NameListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:NameListIdentifier];
    }
    NSUInteger row = [indexPath row];
    
    
    
    //this gets the Appointment from the appointment array in user. It uses the number
    //of the row its populating to know which object to get. This methods runs like a loop
    Appointments *appt = [currentUser2.appointments objectAtIndex:row];
    //displays the Date of the Appointment
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"MM/dd/yyyy";
    NSString* dateString = [df stringFromDate:appt.date];  // Don't use leading caps on variables
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", dateString];
    //displays the details
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@",
								 appt.time, appt.course, appt.tutorID];
    
    //cell.selectedBackgroundView.backgroundColor = [];
    cell.backgroundColor = [UIColor colorWithRed:44 green:62 blue:80 alpha:0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


//Deletes selected row from database and user appointments array
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSUInteger row = [indexPath row];
    NSManagedObjectContext *context = [self managedObjectContext];

    [context deleteObject:[currentUser2.appointments objectAtIndex:row]];
    
    
    [currentUser2.appointments removeObjectAtIndex:row];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    
    
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}



//push on to the new appointment view
- (IBAction)newAppointment:(id)sender {
    
    UIViewController  *childController = [[self storyboard] instantiateViewControllerWithIdentifier:@"new"];
    
    
    //UINavigationController  *navController = [[self storyboard] instantiateViewControllerWithIdentifier:@"2"];
    
    [self.navigationController pushViewController:childController animated:YES];
}
@end
