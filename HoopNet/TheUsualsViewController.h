//
//  TheUsualsViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TheUsualsViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

/*
 allSections and filtered sections contain information displayed in the table view
 the way we know which dictionary to use depends on the Bool isFiltered
 */
@property NSMutableDictionary *allSections;
@property NSMutableDictionary *allFilteredSections;
/*
 nameArrays is a NSMutableArray of NSmutableArrays containing name, and display name pairs
 */
@property NSMutableArray *nameArrays;
/*
 contactInfo is a dictionary that will map display names to a persons contact information
 to be displayed in the editTheUsuals View
 */
@property NSMutableDictionary *contactInfo;

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
