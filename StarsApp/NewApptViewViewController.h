//
//  NewApptViewViewController.h
//  StarsApp
//
//  Created by robert jose gomez on 12/7/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "Tutor.h"

//constant variables for the components
#define kMajorComponent   0
#define kCourseComponent   1
#define kTutorComponent   2

@interface NewApptViewViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    UIPickerView *picker;
    NSDictionary *majCourses;
    NSArray      *majors;
    NSArray      *courses;
    NSMutableArray      *tutorList;
    
}
//declare uipicker
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

//declare the rest of the properties
@property (retain, nonatomic) NSDictionary *majCourses;
@property (retain, nonatomic) NSArray *majors;
@property (retain, nonatomic) NSArray *courses;
@property (retain, nonatomic) NSArray *list;
@property (retain, nonatomic) NSMutableArray *tutorList;
@property (retain, nonatomic) NSMutableArray *tNames;
@property (retain, nonatomic) NSDictionary *allTutors;
@property (strong, nonatomic)User *currentUserNew;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UISearchBar *SrchBar;
//@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic)NSMutableArray *allcourses;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) IBOutlet UIDatePicker *date;
@property (strong, nonatomic) NSString *selectedCourse;
@property (strong, nonatomic) Tutor *selectedT;






- (IBAction)submitBttn:(id)sender;

@end
