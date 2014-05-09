//
//  InviteUsersViewController.h
//  HoopNet
//
//  Created by Vincent Oe on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TheUsualsViewController.h"

@interface InviteUsersViewController : TheUsualsViewController

@property (weak, nonatomic) NSString* eventName;

@property (weak, nonatomic) NSString* eventLocation;

@property (weak, nonatomic) NSDate* eventDate;




@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*
 Search bar object to search through The Usuals table view
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end
