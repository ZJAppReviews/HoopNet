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
 List of friends 
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*
 Search bar object to search through The Usuals table view
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end
