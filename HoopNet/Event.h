//
//  Event.h
//  HoopNet
//
//  Created by Vincent Oe on 5/8/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property NSString* name;
@property NSDate* date;
@property NSString* location;
@property NSString* organizer;
@property NSMutableArray* usersInvited;
@property NSMutableArray* usersGoing;

-initWithName:(NSString*)name date:(NSDate*)date location:(NSString*)location organizer:(NSString*)organizer;

@end
