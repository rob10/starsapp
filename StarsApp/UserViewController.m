/*


//
//  UserViewController.m
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize test, currentUser3, Name, emailTxt, majTxt, descTxt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
     //instantiate singleton User
     currentUser3 = [User sharedDB];
    
    //display the values of current user
    Name.text = currentUser3.name;
    emailTxt.text = currentUser3.email;
    majTxt.text = currentUser3.major;
    descTxt.text = currentUser3.desc;
    
    
    //disable text fields so they can't edit them
    Name.enabled = FALSE;
    emailTxt.enabled = FALSE;
    majTxt.enabled = FALSE;
    descTxt.enabled = FALSE;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

*/


 
 
//
//  UserViewController.m
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "UserViewController.h"





@implementation UserViewController
{
    BOOL new;
}

@synthesize test, currentUser3, Name, emailTxt, majTxt, descTxt, showImage, imageToSave, pwTxt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//enable or disable the text fields depneding if its a new user or current user. secure password input and initialize the singleton user
- (void)viewDidLoad
{
    //instantiate singleton User
    currentUser3 = [User sharedDB];
    pwTxt.secureTextEntry = YES;
    
    //display the values of current user
    
    if([currentUser3.name  isEqual: @""])
    {
        Name.text = currentUser3.name;
        emailTxt.text = currentUser3.email;
        majTxt.text = currentUser3.major;
        descTxt.text = currentUser3.desc;
        pwTxt.text = currentUser3.password;
        
        [self disableText];
    }
    else{
        Name.text = currentUser3.name;
        emailTxt.text = currentUser3.email;
        majTxt.text = currentUser3.major;
        descTxt.text = currentUser3.desc;
        pwTxt.text = currentUser3.password;
        
        [self enableText];
    }
    
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//disables textfields
-(void) disableText{
    //disable text fields so they can't edit them
    self.Name.enabled = FALSE;
    self.emailTxt.enabled = FALSE;
    self.majTxt.enabled = FALSE;
    self.descTxt.enabled = FALSE;
    self.pwTxt.enabled = FALSE;
    
}
//enable textfields
-(void)enableText{
    self.Name.enabled = TRUE;
    self.emailTxt.enabled = TRUE;
    self.majTxt.enabled = TRUE;
    self.descTxt.enabled = TRUE;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//calls enable text fields method
- (IBAction)btnEdit:(id)sender {
    [self enableText];
}


//method used for managedobject
- (NSManagedObjectContext *)managedObjectContext {
    
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//This method checks if the array of users is empty or if its populated, if it has users in it then it updates the values. if it is empty then it makes adds a new user to the database.
- (IBAction)btnChange:(id)sender {
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"User"
                inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"self.userID == %@", currentUser3.userID];
    [request setPredicate:predicate];
    NSLog(@"%@", currentUser3);
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([array count] != 0) {
        //        NSLog(@"%i", count);
        
        NSManagedObject* updatedUser = [array objectAtIndex:0];
        NSLog(@"name :%@", [updatedUser valueForKey: @"name"]);
        [updatedUser setValue:currentUser3.userID forKey:@"userID"];
        [updatedUser setValue:Name.text forKey:@"name"];
        [updatedUser setValue:self.emailTxt.text forKey:@"email"];
        [updatedUser setValue:self.majTxt.text forKey:@"major"];
        [updatedUser setValue:self.descTxt.text forKey:@"desc"];
        [updatedUser setValue:self.pwTxt forKey:@"password"];
        
    }
    else {
        NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [newUser setValue:currentUser3.userID forKey:@"userID"];
        [newUser setValue:Name.text forKey:@"name"];
        [newUser setValue:self.emailTxt.text forKey:@"email"];
        [newUser setValue:self.majTxt.text forKey:@"major"];
        [newUser setValue:self.descTxt.text forKey:@"desc"];
        [newUser setValue:self.pwTxt forKey:@"password"];
        
        currentUser3 = [User sharedDB];
        [currentUser3 setUser:[newUser valueForKey:@"userID"] andName:[newUser valueForKey:@"name"]  andEmail:[newUser valueForKey:@"email"]  andMajor:[newUser valueForKey:@"major"]  andDesc:[newUser valueForKey:@"desc"]  andPassword:[newUser valueForKey:@"password"]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                        message:@"thank you for joining FIU Stars!"
                                                       delegate:nil
                                              cancelButtonTitle:@"You're Welcome!"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    

    
}
//shows the camera view
#pragma mark - Camera Image Interface
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    // Does hardware support a camera
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
}

//takes the picture selected and saves it to our image property then dismisses camera
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    
    
    imageToSave = (UIImage *) [info objectForKey:
                               UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    // View the image on screen
    showImage.image = imageToSave;
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion: ^{[self doSomethingElse];} ];
    //[picker release];
}

-(BOOL)new
{
    return new;
}

//button action for camera
- (IBAction)showCameraUI:(id)sender {
    
    
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
    
}
- (void) doSomethingElse {
    NSLog(@"Camera Dismissed");
    
}

@end








