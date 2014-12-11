//
//  DetailViewController.h
//  StarsApp
//
//  Created by robert jose gomez on 12/6/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
