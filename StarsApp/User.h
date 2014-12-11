//
//  User.h
//  StarsApp
//
//  Created by robert jose gomez on 12/6/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointments.h"

@interface User : NSObject



@property (nonatomic, copy) NSString * userID;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * major;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSMutableArray *appointments;

//singleton method
+ (id)sharedDB;
//set user method
-(void) setUser: (NSString *) uid andName: (NSString *) nme andEmail: (NSString *) mail andMajor: (NSString *) maj andDesc:(NSString *) decrip andPassword: (NSString *) pw;

-(void) addAppointment: (Appointments *) appt;


@end
