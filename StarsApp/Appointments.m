//
//  Appointments.m
//  StarsApp
//
//  Created by robert jose gomez on 12/6/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "Appointments.h"

@implementation Appointments

@synthesize date, time, course, userID, tutorID;

//sets appointment fields
-(void) setClass:(NSString *)cours andDate:(NSDate *)day andTime:(NSString *)hour andUser:(NSString *)uid andTutor:(NSString *)tid
{
    course = cours;
    date = day;
    time = hour;
    userID = uid;
    tutorID = tid;
    
}


@end
