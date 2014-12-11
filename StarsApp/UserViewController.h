//
//  UserViewController.h
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>



@interface UserViewController : UIViewController <NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *test;

//properties for the textfields
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *majTxt;
@property (weak, nonatomic) IBOutlet UITextField *descTxt;
@property (strong, nonatomic) IBOutlet UITextField *pwTxt;
//curent user
@property (strong, nonatomic)User *currentUser3;

//button actions
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnChange:(id)sender;


//camera methods
- (IBAction)showCameraUI:(id)sender;
-(void)doSomethingElse;
//properties for the image taken form the camera
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak,nonatomic)UIImage  *imageToSave;
-(BOOL)new;

//enable and disable text
-(void)disableText;
-(void)enableText;


@end