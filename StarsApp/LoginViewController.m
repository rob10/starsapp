//
//  LoginViewController.m
//  FIUStars
//
//  Created by robert jose gomez on 11/30/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtLogin;
@synthesize txtPassword;
@synthesize users;
@synthesize currentUser;
@synthesize allAppointments;



//This method is used to handle the managed object for core data
- (NSManagedObjectContext *)managedObjectContext {
    
    
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


//In the viewdidload I make an instance of the managed object, I create 2 fetchrequests to look up properties in
//both databases. Then I set currentUser, which is a singleton of user class, to the first object in the user database just so it won't run into some null error on its first run.
- (void)viewDidLoad
{
    self.navigationItem.title = @"Sign out";
    //self.navigationItem.titleView.hidden = YES;
    
    //Add user or appointment to their database
    NSManagedObjectContext *context = [self managedObjectContext];
    
    

    //NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    //NSManagedObject *newManagedObject2 = [NSEntityDescription insertNewObjectForEntityForName:@"Appointments" inManagedObjectContext:context];

    
   
    /*[newManagedObject setValue:@"1" forKey:@"userID"];
     [newManagedObject setValue:@"Robert Gomez" forKey:@"name"];
     [newManagedObject setValue:@"test@test.com" forKey:@"email"];
     [newManagedObject setValue:@"Information Technology" forKey:@"major"];
     [newManagedObject setValue:@"Senior at FIU" forKey:@"desc"];
     [newManagedObject setValue:@"test" forKey:@"password"];*/
    
//    NSDate *date = [[NSDate alloc]init];
//    
//
//     [newManagedObject2 setValue:@"CGS 4001" forKey:@"course"];
//     [newManagedObject2 setValue:date forKey:@"date"];
//     [newManagedObject2 setValue:@"6:00 PM - 9:00 PM" forKey:@"time"];
//     [newManagedObject2 setValue:@"1" forKey:@"userID"];
//     [newManagedObject2 setValue:@"John Doe" forKey:@"tutorID"];
    
    
    
    
    //this is used to retrieve the data from user database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    //this gets all the objects in the database and puts it in a Array
    self.users = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //this does the same as above but for Appointments
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Appointments"];
    self.allAppointments = [[context executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    

    
    //Instantiate singleton user
    currentUser = [User sharedDB];
    
    //Since I am just testing it with the one user I made I'm just setting that object to a temporary instance of User
    User *tempUser = [users objectAtIndex:0];
// 
//    //set the fields for the singleton instance of User
    [currentUser setUser:tempUser.userID andName:tempUser.name andEmail:tempUser.email andMajor:tempUser.major andDesc:tempUser.desc andPassword:tempUser.password];
    
    

    
    //adding appointments to User Array
    for(Appointments *appt in allAppointments)
    {
        //if user IDs match then add appointment object to appointments array in user class
        if([appt.userID isEqualToString:currentUser.userID])
        {
    
    
           [currentUser addAppointment:appt];
    
        }
    }
    
  
    //just a test to check how many appointments are in the appointmets array
    
    //NSLog(@"%@", users);
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    txtPassword.secureTextEntry = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Populate tutor and classes with infofrom plist
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This segue is from the login to the user controller. So we set the fields in currentUser to blank so when
//the user is about to enter the his information all fields will be blank.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"user"]) {
        NSLog(@"test seg");
        User* usr= [[User alloc] init];
        [usr setUser:[NSString stringWithFormat:@"%u", [users count]+1] andName:@"" andEmail:@"" andMajor:@"" andDesc:@"" andPassword:@""];
        UserViewController *destViewController = segue.destinationViewController;
        destViewController.currentUser3 = usr;
    }
}

//This is the button action method, it also sets the current user fields to blank as a backup just incase it doesn't work in the prepare for segue. Then it calls the prepare for segue method.
- (IBAction)btnNewAccount:(id)sender {
    
    //    UIViewController  *childController = [[self storyboard] instantiateViewControllerWithIdentifier:@"user"];
    //
    //    [self.navigationController pushViewController:childController animated:YES];
    
    [currentUser setUser:[NSString stringWithFormat:@"%u", [users count]+1] andName:@"" andEmail:@"" andMajor:@"" andDesc:@"" andPassword:@""];
    
    [self performSegueWithIdentifier: @"user" sender: self];
}


//Everytime the view appears it empties the textfields. Then it adds all the users from the user database to the global user array so all new users are added.
-(void) viewWillAppear:(BOOL)animated{
    
    txtLogin.text = @"";
    txtPassword.text = @"";
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
}



//Login button method. This checks if the login and password match with any user in our database. if it does it sets the current user to the user it matched then it pushes on through to the tabbarcontroller. If not it gives the user an allertview telling him his password is wrong.
- (IBAction)btnLogin:(id)sender {
    
    
     
    
    bool results= FALSE;
    
    for (User *obj in self.users) {
        //        NSLog(@"%@ , %@", obj.userID, [self.txtLogin.text isEqual:obj.userID] ? @"true": @"false");
        
        
        if ( [self.txtLogin.text isEqual:obj.userID] && [self.txtPassword.text isEqual: obj.userID]) {
            
            results = YES;
            currentUser = [User sharedDB];
            [currentUser setUser:obj.userID andName:obj.name andEmail:obj.email andMajor:obj.major andDesc:obj.desc andPassword:obj.password];
            
            /*for(Appointments *appt in allAppointments)
            {
                //if user IDs match then add appointment object to appointments array in user class
                if([appt.userID isEqualToString:currentUser.userID])
                {
                    NSLog(@"test");
                    
                    [currentUser addAppointment:appt];
                    
                }
            }*/
            
        }
        
        
        if ( [self.txtLogin.text isEqual:obj.email] && [self.txtPassword.text isEqual: obj.password]) {
            
            results = YES;
            currentUser = [User sharedDB];
            [currentUser setUser:obj.userID andName:obj.name andEmail:obj.email andMajor:obj.major andDesc:obj.desc andPassword:obj.password];
            
        }
        
    }
    
    if (results)
        
    {
        
        UITabBarController  *childController = [[self storyboard] instantiateViewControllerWithIdentifier:@"tab"];
        
        [self.navigationController pushViewController:childController animated:YES];
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                        message:@"Incorrect Username or password"
                                                       delegate:nil
                                              cancelButtonTitle:@"Got It"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}
    
    


    

    
@end
    

