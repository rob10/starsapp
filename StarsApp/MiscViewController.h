//
//  MiscViewController.h
//  StarsApp
//
//  Created by robert jose gomez on 12/7/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MiscViewController : UIViewController<MFMailComposeViewControllerDelegate>

//email action
- (IBAction)emailBttn:(id)sender;


@end
