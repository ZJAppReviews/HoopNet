//
//  MyEventsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "MyEventsViewController.h"
#import "MyEventsTableViewCell.h"
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
    
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.eventArray = [[NSMutableArray alloc] init];
    
    //pre-seed the datasource
    NSDate* fakeDate = [[NSDate alloc] init];
    Event *event1 = [[Event alloc] initWithName:@"event1" date:fakeDate location:@"place1"];
    Event *event2 = [[Event alloc] initWithName:@"event2" date:fakeDate location:@"place2"];
    [self.eventArray addObject:event1];
    [self.eventArray addObject:event2];
    NSLog(@"events just added to EventArray");

    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem  = addButton;
}


- (IBAction) addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createNewEventSegue" sender:self];
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
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:26];
        for(int i = 0; i < 26; i++) {
            [tempDic setObject:[[NSMutableArray alloc]initWithObjects:nil] forKey:[NSNumber numberWithInt:i]];
        }
        for(int sectionIndex = 0; sectionIndex < 26; sectionIndex++) {
            NSMutableArray *currentSection = [self.allSections objectForKey:[NSNumber numberWithInt:sectionIndex]];
            NSMutableArray *sectionToAddTo = [tempDic objectForKey:[NSNumber numberWithInt:sectionIndex]];
            for (NSMutableArray *nameArray in currentSection) {
                NSString *nameStr = [nameArray objectAtIndex:0];
                NSString *displayNameStr = [nameArray objectAtIndex:1];
                NSRange nameStringRange = [nameStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSRange displayNameStringRange = [displayNameStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if(nameStringRange.location != NSNotFound || displayNameStringRange.location != NSNotFound) {
                    [sectionToAddTo addObject:nameArray];
                }
            }
        }
        self.allFilteredSections = [tempDic copy];
    }
    [self.tableView reloadData];
}

/*
 Returns the number of existing sections (Those with nil number of rows are excluded in another method)
 */
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    NSLog(@"Inside numberOfSectionsInTableView");
    return 1;
}

/*
 Returns the number of rows in the table
 */
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Inside numberOfRowsInSection");
    NSLog(@"%d", [self.eventArray count]);

    return [self.eventArray count];
}

/*
 This method implements the physical features of the cells in the table view
 */
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"HERE");
    
    MyEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomEventCell"];
    if(cell == nil) {
        cell = [[MyEventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomEventCell"];
    }
    
    
    Event* event = [self.eventArray objectAtIndex:indexPath.row];
    
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
        [self refreshAllSections];
        
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
