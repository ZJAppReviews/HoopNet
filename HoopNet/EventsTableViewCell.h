//
//  EventsTableViewCell.h
//  HoopNet
//
//  Created by Vincent Oe on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventOrganizer;
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;

@end
