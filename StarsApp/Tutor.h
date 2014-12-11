//
//  Tutor.h
//  StarsApp
//
//  Created by robert jose gomez on 12/9/14.
//  Copyright (c) 2014 rgome117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tutor : NSObject



@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary *timeSlots;


-(void) setTutor: (NSString *) nme andTime: (NSDictionary *) tme;


@end
