//
//  NewApptViewViewController.m
//  StarsApp
//
//  Created by robert jose gomez on 12/7/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "NewApptViewViewController.h"

@interface NewApptViewViewController ()

@end

@implementation NewApptViewViewController

@synthesize majCourses, majors, courses, picker, tutorList, list, tNames, allTutors, currentUserNew, startTime, endTime,SrchBar,allcourses, searchResults, date, selectedCourse, selectedT;


//Same managedobject method as before
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


//This reads all of the information from the User and Courses plist. It reads it into a dictionary and then i set that dictionary to a global dictionary i declared for future use. The I seperate all the information into different arays to be able to use them for the UIpicker and the UIsearchbar.
- (void)viewDidLoad
{
    //picker = [[UIPickerView alloc]init];
    
    currentUserNew = [User sharedDB];
    
    [picker setDataSource:self];
    [picker setDelegate:self];
   
    
    
    list = [[NSArray alloc]init];
    tutorList = [[NSMutableArray alloc]init];
    tNames = [[NSMutableArray alloc]init];
    allcourses = [[NSMutableArray alloc]init];
    
    
   NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Courses" ofType:@"plist"]];
    
    //NSDictionary *dictRoot2 = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Tutors" ofType:@"plist"]];
    
    NSDictionary *dictRoot2 = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Tutors" ofType: @"plist"]];
    
    majCourses = dictRoot;
    allTutors = dictRoot2;
    NSArray *temp = [majCourses allKeys];
    majors = temp;
    NSString *majorChosen = [majors objectAtIndex:0];
    NSArray *array = [majCourses objectForKey:majorChosen];
    NSArray *array2 = [allTutors objectForKey:majorChosen];
    courses = array;
    list = array2;
    
    //NSMutableArray *tempCourses = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < [majCourses count]; i++)
    {
        NSLog(@"test");
        NSArray *test = [majCourses objectForKey:[majors objectAtIndex:i]];
        
        for(NSString *cour in test)
        {
            [allcourses addObject:cour];
        }
    }
    
    //NSLog(@"%@", allcourses);
    
    
    
    
    for(NSArray *arr in list)
    {
        Tutor *tut = [[Tutor alloc]init];
        
        [tut setTutor:[arr objectAtIndex:0] andTime:[arr objectAtIndex:1]];
        
        [tutorList addObject:tut];
        
    }
    
    for (Tutor *name in tutorList)
    {
        NSLog(@"%@", name.name);
        [tNames addObject:name.name];
        
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Get the number of components(columns) for the picker
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

//This gets the count from each list that is going to be populating each component
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return [self.majors count];
    else if (component == 1)
        return [self.courses count];
    return [self.tutorList count];
}

//this makes the second and third component dependent on the first component
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
   
    
    if (component == 0)
        return [self.majors objectAtIndex:row];
    else if (component ==1)
        return [self.courses objectAtIndex:row];
    return [self.tNames objectAtIndex:row];
}

//this midifies the width between components
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    if (component == 2)
        return 300;
    else if (component == 1)
        return 200;
    return 300;
}

//This populates the components
- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *selectedState = [self.majors objectAtIndex:row];
        NSArray *array = [majCourses objectForKey:selectedState];
        NSArray *array2 = [allTutors objectForKey:selectedState];
        NSMutableArray *array3 = [[NSMutableArray alloc]init];
        NSMutableArray *array4 = [[NSMutableArray alloc]init];
        self.courses = array;
        self.list = array2;
        //Tutor *tutor = [self.tutorList objectAtIndex:row];
        for(NSArray *arr in list)
        {
            Tutor *tut = [[Tutor alloc]init];
            
            [tut setTutor:[arr objectAtIndex:0] andTime:[arr objectAtIndex:1]];
            
            [array3 addObject:tut];
            
        }
        self.tutorList = array3;
        for (Tutor *name in tutorList)
        {
           
            [array4 addObject:name.name];
            
        }
        self.tNames = array4;
        
        [picker selectRow:0 inComponent:1 animated:YES];
        [picker selectRow:0 inComponent:2 animated:YES];
        [picker reloadComponent:1];
        [picker reloadComponent:2];
    }
}







//This creates the new appointment for the user, it calls the managedobject method to create a new row in the database, then it also adds the appointment to the current user appointments array. Then after its donw it pops back to the appointments controller
- (IBAction)submitBttn:(id)sender {
    
    NSInteger majorRow = [picker selectedRowInComponent:0];
    NSInteger courseRow = [picker selectedRowInComponent:1];
	//NSInteger tutorRow = [picker selectedRowInComponent:2];
    
    NSString *major = [self.majors objectAtIndex:majorRow];
    NSString *course = [self.courses objectAtIndex:courseRow];
    Tutor *tutor = [self.tutorList objectAtIndex:0];
    
    NSLog(@"Major: %@", major);
    NSLog(@"Course: %@", course);
    NSLog(@"Tutor: %@", tutor.name);
    
    //LoginViewController *lgvc = [self.navigationController.viewControllers objectAtIndex:0];
    
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *newManagedObject2 = [NSEntityDescription insertNewObjectForEntityForName:@"Appointments" inManagedObjectContext:context];
	NSString *times = [NSString stringWithFormat:@"%@ - %@", startTime.text, endTime.text];
    
    [newManagedObject2 setValue:course forKey:@"course"];
    [newManagedObject2 setValue:date.date forKey:@"date"];
    [newManagedObject2 setValue:times forKey:@"time"];
    [newManagedObject2 setValue:currentUserNew.userID forKey:@"userID"];
    [newManagedObject2 setValue:tutor.name forKey:@"tutorID"];
    
    Appointments *appt = [[Appointments alloc]init];
    
    [appt setClass:course andDate:date.date andTime:times andUser:currentUserNew.userID andTutor:tutor.name];
    
    [currentUserNew addAppointment:appt];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Appointments"];
    
    NSArray *test = [[context  executeFetchRequest:fetch error:nil] mutableCopy];
    
    for(Appointments *show in test)
    {
        NSLog(@"%@", show.course);
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//This a data source method for the search bar display controller, it either the count of all courses or the count of courses being searched
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [searchResults count];
    }
    else{
        return [allcourses count];
    }
    
}

//This populates the tableview cells with the information of the courses
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SrchBar.hidden = FALSE;
    
    static NSString *NameListIdentifier = @"NameListIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameListIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NameListIdentifier];
    }
    
    // Display recipe in the table cell
    NSUInteger row = [indexPath row];
    
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [searchResults objectAtIndex:row];
    }
    else{
        cell.textLabel.text = [allcourses objectAtIndex:row];
    }
    
    
    //..cell.textLabel.text = [allcourses objectAtIndex:row];
    
    
    return cell;
}

//this uses a predicate to search through the array of courses, and sets the search results to what the user is typing
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    searchResults = [allcourses filteredArrayUsingPredicate:resultPredicate];
}

///This calls the method that searches through the courses array and passes it the values neded
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


//This method gets the value of the cell the user selected and also picks a tutor for the user. it disables the pickerview since the fields are already set through the search
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [picker setUserInteractionEnabled:NO];
    
    
    SrchBar.text = @"";
    
    
    selectedCourse = [allcourses objectAtIndex:indexPath.row];
    selectedT = [self.tutorList objectAtIndex:0];
    
    SrchBar.placeholder =[NSString stringWithFormat:@"Selected Course: %@ Tutor: %@ proceed to select Date and Time",  selectedCourse, selectedT ];
    
    
}

@end
