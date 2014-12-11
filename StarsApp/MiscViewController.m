//
//  MiscViewController.m
//  FIUStars
//
//  Created by robert jose gomez on 12/2/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "MiscViewController.h"

@implementation MiscViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//This shows the mailview, then sets the recopient and subject. and calls the dismiss method when finished
- (IBAction)emailBttn:(id)sender {
    
    MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
    mailCont.mailComposeDelegate = self;
    
    
    [mailCont setToRecipients:[NSArray arrayWithObject:@"aaust020@fiu.edu"]];
    [mailCont setSubject:@"Stars App Feedback"];
    
    
    [self presentViewController:mailCont animated:YES completion:nil];

    
}

//dismiss method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
