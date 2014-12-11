//
//  Appointments.h
//  StarsApp
//
//  Created by robert jose gomez on 12/6/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appointments : NSObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * tutorID;


//sets appointment
-(void)setClass:(NSString *) cours andDate:(NSDate *) day andTime:(NSString *) hour andUser:(NSString *)uid andTutor:(NSString *) tid;

@end
