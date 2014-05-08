//
//  Event.m
//  HoopNet
//
//  Created by Vincent Oe on 5/8/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "Event.h"

@implementation Event

-initWithName:(NSString*)name date:(NSDate*)date location:(NSString*)location {
    if (self = [super init]) {
        self.name = name;
        self.date = date;
        self.location = location;
    }
    
    return self;
}

@end
