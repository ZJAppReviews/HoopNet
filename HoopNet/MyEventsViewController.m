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
    
    self.goingEventsArray = [[NSMutableArray alloc] init];
    self.filteredGoingEventsArray = [[NSMutableArray alloc] init];
    
    self.invitedEventsArray = [[NSMutableArray alloc] init];
    self.filteredInvitedEventsArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem  = addButton;
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(homeButtonPressed:)];
    self.navigationItem.leftBarButtonItem = homeButton;
    
    isFiltered = NO;
    
    //Starting my query to add my events
    PFUser *currentUser = [PFUser currentUser];
    NSString *currentUserName = currentUser[@"username"];
    
    //seed the goingEventsArray
    PFQuery *goingEventsQuery = [PFQuery queryWithClassName:@"Events"];
    [goingEventsQuery whereKey:@"Going" equalTo:currentUserName];
    [goingEventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                NSDate *when = object[@"When"];
                NSString *eventTitle = object[@"Name"];
                NSString *organizer = object[@"Organizer"];
                NSString *where = object[@"Where"];
                //NSMutableArray *going = object[@"Going"];
                //NSMutableArray *invited = object[@"Invited"];
                
                Event *curEvent = [[Event alloc] initWithName:eventTitle date:when location:where organizer:organizer];
                [self.goingEventsArray addObject:curEvent];
                [self.tableView reloadData];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //query for the invited users
    PFQuery *invitedEventsQuery = [PFQuery queryWithClassName:@"Events"];
    [invitedEventsQuery whereKey:@"Invited" equalTo:currentUserName];
    [invitedEventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                NSDate *when = object[@"When"];
                NSString *eventTitle = object[@"Name"];
                NSString *organizer = object[@"Organizer"];
                NSString *where = object[@"Where"];
                //NSMutableArray *going = object[@"Going"];
                //NSMutableArray *invited = object[@"Invited"];
                
                Event *curEvent = [[Event alloc] initWithName:eventTitle date:when location:where organizer:organizer];
                [self.invitedEventsArray addObject:curEvent];
                [self.tableView reloadData];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

/*
 performs the proper segue to lead to the create new Event Controller
 */
- (IBAction) addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createNewEventSegue" sender:self];
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
 Brings up cancel button when the search bar is in use.
 */
- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar {
    [searchBar setShowsCancelButton: YES animated: YES];
}

/*
 Provides functionality for when the cancel button in the search bar is clicked
 */
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isFiltered = NO;
    [self.tableView reloadData];
    searchBar.text = @"";
    [searchBar setShowsCancelButton: NO animated: NO];
    [searchBar resignFirstResponder];
}

/*
 Provides functionality for when the search button in the keyboard is clicked
 */
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton: NO animated: NO];
    [self.searchBar resignFirstResponder];
    
}

/*
 This method is called everytime the search bar is in use and the inputs change
 This provides the functionality for filtering the table view
 */
- (void) searchBar:(UISearchBar *) searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        isFiltered = NO;
    }else {
        isFiltered = YES;
        
        self.filteredGoingEventsArray = [[NSMutableArray alloc] init];
        self.filteredInvitedEventsArray = [[NSMutableArray alloc] init];
        
        for(Event *event in self.goingEventsArray) {
            NSString *nameString = event.name;
            NSString *locationString = event.location;
            NSString *organizerString = event.organizer;
            
            NSRange nameStringRange = [nameString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange locationStringRange = [locationString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange organizerStringRange = [organizerString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameStringRange.location != NSNotFound
               || locationStringRange.location != NSNotFound
               || organizerStringRange.location != NSNotFound) {
                [self.filteredGoingEventsArray addObject:event];
            }
        }
        for(Event *event in self.invitedEventsArray) {
            NSString *nameString = event.name;
            NSString *locationString = event.location;
            NSString *organizerString = event.organizer;
            
            NSRange nameStringRange = [nameString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange locationStringRange = [locationString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange organizerStringRange = [organizerString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameStringRange.location != NSNotFound
               || locationStringRange.location != NSNotFound
               || organizerStringRange.location != NSNotFound) {
                [self.filteredInvitedEventsArray addObject:event];
            }
        }
    }
    [self.tableView reloadData];
}

/*
 Returns the number of existing sections (Those with nil number of rows are excluded in another method)
 */
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return 2;
}

/*
 Returns the number of rows in the table
 */
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (isFiltered) {
            return [self.filteredGoingEventsArray count];
        } else {
            return [self.goingEventsArray count];
        }
    } else {
        if (isFiltered) {
            return [self.filteredInvitedEventsArray count];
        } else {
            return [self.invitedEventsArray count];
        }
    }
}

/*
 This method implements the physical features of the cells in the table view
 */
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventsCell"];
    if(cell == nil) {
        cell = [[EventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventsCell"];
    }
    Event* event;
    if (indexPath.section == 0) {
        if (isFiltered) {
            event = [self.filteredGoingEventsArray objectAtIndex:indexPath.row];
        } else {
            event = [self.goingEventsArray objectAtIndex:indexPath.row];
        }
    } else {
        if (isFiltered) {
            event = [self.filteredInvitedEventsArray objectAtIndex:indexPath.row];
        } else {
            event = [self.invitedEventsArray objectAtIndex:indexPath.row];
        }
    }
    cell.eventName.text = event.name;
    cell.eventLocation.text = event.location;
    cell.eventOrganizer.text = event.organizer;
    NSDate* dateInfo = event.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    NSString *dateString = [dateFormatter stringFromDate: dateInfo];
    cell.eventDate.text = dateString;
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"HH:mm";
    NSString *timeString = [timeFormatter stringFromDate: dateInfo];
    cell.eventTime.text = timeString;
    
    return cell;
}

/*
 Uses the segue editTheUsualsSegue in order to transfer data from The Usuals to EditVC
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"viewEventSegue" sender:self];
}

/*
 Prepare for the segue
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"viewEventSegue"]) {
        ViewEventsViewController *destinationController = segue.destinationViewController;
        
        //Abstracts data needed from args in order to retrieve a cell name and cell display name
        int sectionIndex = self.tableView.indexPathForSelectedRow.section;
        int arrayIndex = self.tableView.indexPathForSelectedRow.row;
        Event* selectedEvent;
        if (sectionIndex == 0) {
            if (isFiltered) {
                selectedEvent = [self.filteredGoingEventsArray objectAtIndex:arrayIndex];
            } else {
                selectedEvent = [self.goingEventsArray objectAtIndex:arrayIndex];
            }
        } else {
            if (isFiltered) {
                selectedEvent = [self.filteredInvitedEventsArray objectAtIndex:arrayIndex];
            } else {
                selectedEvent = [self.invitedEventsArray objectAtIndex:arrayIndex];
            }
        }
        destinationController.currentEvent = selectedEvent;
        destinationController.navigationController.title = selectedEvent.name;
        
    }else if ([segue.identifier isEqualToString:@"createNewEventSegue"]) {
        //This is executed when the + icon is pressed
    }
}

/*
 This method helps us name each of the section headers
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Commited";
    } else {
        return @"Maybies";
    }
}

/*
 Method used to deselect cells in the table view
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Unselect the selected row if any
    NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

/*
 Editing a cell
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

/*
 Swipe Deleting a cell
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *oldWhen;
    NSString *oldEventTitle;
    NSString *oldOrganizer;
    NSString *oldWhere;
    //NSMutableArray *oldGoing;
    //NSMutableArray *oldInvited;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Event* eventToDelete;
        if (indexPath.section ==0) {
            if (isFiltered) {
                eventToDelete = [self.filteredGoingEventsArray objectAtIndex:indexPath.row];
                oldWhen = eventToDelete.date;
                oldEventTitle = eventToDelete.name;
                oldOrganizer = eventToDelete.organizer;
                oldWhere = eventToDelete.location;
                //NSMutableArray *oldGoing = eventToDelete.going;
                //NSMutableArray *oldInvited = eventToDelete.invited;
                [self.filteredGoingEventsArray removeObject:eventToDelete];
                [self.goingEventsArray removeObject:eventToDelete];
            } else {
                eventToDelete = [self.goingEventsArray objectAtIndex:indexPath.row];
                oldWhen = eventToDelete.date;
                oldEventTitle = eventToDelete.name;
                oldOrganizer = eventToDelete.organizer;
                oldWhere = eventToDelete.location;
                //NSMutableArray *oldGoing = eventToDelete.going;
                //NSMutableArray *oldInvited = eventToDelete.invited;
                [self.goingEventsArray removeObject:eventToDelete];
            }
        } else {
            if (isFiltered) {
                eventToDelete = [self.filteredInvitedEventsArray objectAtIndex:indexPath.row];
                oldWhen = eventToDelete.date;
                oldEventTitle = eventToDelete.name;
                oldOrganizer = eventToDelete.organizer;
                oldWhere = eventToDelete.location;
                //NSMutableArray *oldGoing = eventToDelete.going;
                //NSMutableArray *oldInvited = eventToDelete.invited;
                [self.filteredInvitedEventsArray removeObject:eventToDelete];
                [self.invitedEventsArray removeObject:eventToDelete];
            } else {
                eventToDelete = [self.invitedEventsArray objectAtIndex:indexPath.row];
                oldWhen = eventToDelete.date;
                oldEventTitle = eventToDelete.name;
                oldOrganizer = eventToDelete.organizer;
                oldWhere = eventToDelete.location;
                //NSMutableArray *oldGoing = eventToDelete.going;
                //NSMutableArray *oldInvited = eventToDelete.invited;
                [self.invitedEventsArray removeObject:eventToDelete];
            }
        }
        
        if (indexPath.section ==0) {
            //Starting my query to remove myself from an event
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
                        //NSMutableArray *going = object[@"Going"];
                        //NSMutableArray *inited = object[@"Invited"];
                        if ([oldWhen isEqual:when] && [oldEventTitle isEqual:eventTitle] && [oldOrganizer isEqual:organizer] && [oldWhere isEqual:where]) {
                            NSMutableArray *going = object[@"Going"];
                            NSMutableArray *invited = object[@"Invited"];
                        
                            //Edit invited list
                            [invited addObject:currentUserName];
                            [object setObject:invited forKey:@"Invited"];
                    
                            //Edit going list
                            [going removeObject:currentUserName];
                            [object setObject:going forKey:@"Going"];
                        
                            //Save to database and reload UI
                            [object saveInBackground];
                            [self.tableView reloadData];
                        }
                        break;
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        } else {
            //Starting my query to remove myself from an event
            PFUser *currentUser = [PFUser currentUser];
            NSString *currentUserName = currentUser[@"username"];
            PFQuery *myEventsQuery = [PFQuery queryWithClassName:@"Events"];
            [myEventsQuery whereKey:@"Invited" equalTo:currentUserName];
            [myEventsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    for (PFObject *object in objects) {
                        NSDate *when = object[@"When"];
                        NSString *eventTitle = object[@"Name"];
                        NSString *organizer = object[@"Organizer"];
                        NSString *where = object[@"Where"];
                        //NSMutableArray *going = object[@"Going"];
                        //NSMutableArray *inited = object[@"Invited"];
                        if ([oldWhen isEqual:when] && [oldEventTitle isEqual:eventTitle] && [oldOrganizer isEqual:organizer] && [oldWhere isEqual:where]) {
                            NSMutableArray *going = object[@"Going"];
                            NSMutableArray *invited = object[@"Invited"];
                            
                            //Edit invited list
                            [invited removeObject:currentUserName];
                            [object setObject:invited forKey:@"Invited"];
                            
                            ////Edit going list
                            //[going removeObject:currentUserName];
                            //[object setObject:going forKey:@"Going"];
                            
                            //Save to database and reload UI
                            [object saveInBackground];
                            [self.tableView reloadData];
                        }
                        break;
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }
}

@end
