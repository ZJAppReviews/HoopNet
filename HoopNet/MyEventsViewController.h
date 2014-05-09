//
//  MyEventsViewController.h
//  HoopNet
//
//  Created by Vincent Oe on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "SearchEventsViewController.h"
#import "EventsTableViewCell.h"
#import "ViewEventsViewController.h"

@interface MyEventsViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    BOOL isFiltered;
}


/*
 nameArrays is a NSMutableArray of NSmutableArrays containing name, and display name pairs
 */
@property NSMutableArray *goingEventsArray;
@property NSMutableArray *filteredGoingEventsArray;

@property NSMutableArray *invitedEventsArray;
@property NSMutableArray *filteredInvitedEventsArray;

/*
 List of friends
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*
 Search bar object to search through The Usuals table view
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
