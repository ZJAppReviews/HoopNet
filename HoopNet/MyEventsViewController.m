//
//  MyEventsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "MyEventsViewController.h"
#import "MyEventsTableViewCell.h"
#import "EditMyEventViewController.h"
#import "Event.h"

@interface MyEventsViewController ()

@end

@implementation MyEventsViewController {
    BOOL isFiltered;
}

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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem  = addButton;
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(homeButtonPressed:)];
    self.navigationItem.leftBarButtonItem = homeButton;
    
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
    
    
    
    
    /*
    
    //pre-seed the datasource
    NSDate* fakeDate = [[NSDate alloc] init];
    Event *event1 = [[Event alloc] initWithName:@"event1" date:fakeDate location:@"place1" organizer:[PFUser currentUser].username];
    Event *event2 = [[Event alloc] initWithName:@"event2" date:fakeDate location:@"place2" organizer:[PFUser currentUser].username];
    Event *event3 = [[Event alloc] initWithName:@"event3" date:fakeDate location:@"place3" organizer:@"SomeOtherDude"];
    
    //Event *event1 = [[Event alloc] initWithName:@"event1" date:fakeDate location:@"place1" organizer:@"vince"];
    //Event *event2 = [[Event alloc] initWithName:@"event2" date:fakeDate location:@"place2" organizer:@"vince"];
    [self.eventArray addObject:event1];
    [self.eventArray addObject:event2];
    [self.eventArray addObject:event3];
    NSLog(@"events just added to EventArray");
    */
    
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
        
        self.filteredEventArray = [[NSMutableArray alloc] init];

        for(Event *event in self.eventArray) {
            NSString *nameString = event.name;
            NSString *locationString = event.location;
            NSString *organizerString = event.organizer;
            
            NSRange nameStringRange = [nameString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange locationStringRange = [locationString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange organizerStringRange = [organizerString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameStringRange.location != NSNotFound
               || locationStringRange.location != NSNotFound
               || organizerStringRange.location != NSNotFound) {
                [self.filteredEventArray addObject:event];
            }
        }
    }
    [self.tableView reloadData];
}

/*
 Returns the number of existing sections (Those with nil number of rows are excluded in another method)
 */
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return 1;
}

/*
 Returns the number of rows in the table
 */
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    if (isFiltered) {
        return [self.filteredEventArray count];
    } else {
        return [self.eventArray count];
    }
}

/*
 This method implements the physical features of the cells in the table view
 */
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomMyEventCell"];
    if(cell == nil) {
        NSLog(@"HERE");
        cell = [[MyEventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomMyEventCell"];
    }
    
    Event* event;
    
    if (isFiltered) {
        event = [self.filteredEventArray objectAtIndex:indexPath.row];
    } else {
        event = [self.eventArray objectAtIndex:indexPath.row];
    }
    cell.eventName.text = event.name;
    cell.eventLocation.text = event.location;
    cell.eventDate.text = @"";
    cell.eventTime.text = @"";
    
    return cell;
}

/*
 Uses the segue editTheUsualsSegue in order to transfer data from The Usuals to EditVC
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"editEventSegue" sender:self];
}

/*
 Prepare for the segue
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"editEventSegue"]) {
        EditMyEventViewController *destinationController = segue.destinationViewController;
        
        //Abstracts data needed from args in order to retrieve a cell name and cell display name
        int arrayIndex = self.tableView.indexPathForSelectedRow.row;
        Event* selectedEvent = [self.eventArray objectAtIndex:arrayIndex];
        
        destinationController.currentEvent = selectedEvent;
        destinationController.navigationController.title = selectedEvent.name;
        
    }else if ([segue.identifier isEqualToString:@"addNewEventSegue"]) {
        //This is executed when the + icon is pressed
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Event *eventToDelete = [self.eventArray objectAtIndex:indexPath.row];
        [self.eventArray removeObject:eventToDelete];
        
        /*TODO: Send message to server to delete this contact such that allSections doesn't end up with it again*/
        [self.tableView reloadData];
        //add code here for when you hit delete
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
