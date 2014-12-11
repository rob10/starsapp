//
//  User.m
//  StarsApp
//
//  Created by robert jose gomez on 12/6/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userID, email, name, password, appointments, major, desc;


//this is the singleton method
+(id)sharedDB
{
    static User *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[self alloc]init];
    });
    return sharedUser;
    
}

//called from the singleton method. initializes appointments array
-(id)init
{
    if(self =[super init])
    {
        appointments = [[NSMutableArray alloc]init];    }

    
    return self;
}

//sets user fields
-(void)setUser:(NSString *)uid andName:(NSString *)nme andEmail:(NSString *)mail andMajor:(NSString *)maj andDesc:(NSString *)decrip andPassword:(NSString *)pw
{
    userID = uid;
    name = nme;
    email = mail;
    major = maj;
    desc = decrip;
    password = pw;
}

//adds appointment to the array
-(void)addAppointment:(Appointments *)appt
{
    [appointments addObject:appt];
}




@end
