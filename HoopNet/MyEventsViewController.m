//
//  MyEventsViewController.m
//  HoopNet
//
//  Created by Vincent Oe on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "MyEventsViewController.h"

@interface MyEventsViewController ()

@end

@implementation MyEventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.eventArray = [[NSMutableArray alloc] init];
    self.filteredEventArray = [[NSMutableArray alloc] init];
    
    isFiltered = NO;
    
    
    //Starting my query to add contact
    PFUser *currentUser = [PFUser currentUser];
    NSString *currentUserName = currentUser[@"username"];
    PFQuery *myEventsQuery = [PFQuery queryWithClassName:@"Events"];
    [myEventsQuery whereKey:@"Going" equalTo:currentUserName];
    [myEventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSDate *when = object[@"When"];
                NSString *eventTitle = object[@"Name"];
                NSString *organizer = object[@"Organizer"];
                NSString *where = object[@"Where"];
                NSMutableArray *going = object[@"Going"];
                NSMutableArray *inited = object[@"Invited"];
                
                Event *curEvent = [[Event alloc] initWithName:eventTitle date:when location:where organizer:organizer];
                [self.eventArray addObject:curEvent];
                [self.tableView reloadData];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
}




/*
 takes you back to the home page
 */
- (IBAction) homeButtonPressed:(id)sender {
    if (self.tableView.editing) {
        [self.tableView setEditing:NO];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 Swipe Deleting a cell
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Event* eventToDelete;
        if (isFiltered) {
            eventToDelete = [self.filteredEventArray objectAtIndex:indexPath.row];
            [self.eventArray removeObject:eventToDelete];
            [self.filteredEventArray removeObject:eventToDelete];
        } else {
            eventToDelete = [self.eventArray objectAtIndex:indexPath.row];
            [self.eventArray removeObject:eventToDelete];
        }
        
        /*TODO: Send message to server to delete this contact such that allSections doesn't end up with it again*/
        [self.tableView reloadData];
        //add code here for when you hit delete
    }
}

@end
