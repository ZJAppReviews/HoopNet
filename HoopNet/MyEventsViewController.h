//
//  MyEventsViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MyEventsViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

/*
 nameArrays is a NSMutableArray of NSmutableArrays containing name, and display name pairs
 */
@property NSMutableArray *eventArray;
@property NSMutableArray *filteredEventArray;

/*
 List of friends
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*
 Search bar object to search through The Usuals table view
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (void) refreshAllSections;

@end
