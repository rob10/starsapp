//
//  Tutor.m
//  StarsApp
//
//  Created by robert jose gomez on 12/9/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import "Tutor.h"

@implementation Tutor

@synthesize name, timeSlots;



-(void)setTutor:(NSString *)nme andTime:(NSDictionary *)tme
{
    name = nme;
    timeSlots = tme;
    
}




@end
