//
//  TheUsualsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "TheUsualsViewController.h"
#import "EditTheUsualsViewController.h"
#import "CustomCell.h"

@interface TheUsualsViewController ()
{
    /*
     allSections and filtered sections contain information displayed in the table view
     the way we know which dictionary to use depends on the Bool isFiltered
     */
    NSMutableDictionary *allSections;
    NSMutableDictionary *allFilteredSections;
    BOOL isFiltered;
    
    /*
     nameArrays is a NSMutableArray of NSmutableArrays containing name, and display name pairs
     */
    NSMutableArray *nameArrays;
    
    /*
     contactInfo is a dictionary that will map display names to a persons contact information
     to be displayed in the editTheUsuals View
     */
    NSMutableDictionary *contactInfo;
    

}


@end

@implementation TheUsualsViewController



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
    
    
    /*
     Will get name, displayname pairs as a request from the server.
     */
    nameArrays = [[NSMutableArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"David Laroue", @"Dlaroue4", nil],[[NSArray alloc] initWithObjects:@"Vince Oe", @"Oe", nil], [[NSArray alloc] initWithObjects:@"Ethan Lewis", @"Ethanry", nil], [[NSArray alloc] initWithObjects:@"Zack Winchester", @"Zackarious", nil], nil];

    
    /*
     Will fill up the dictionary making requests to server.
     */
    contactInfo = [[NSMutableDictionary alloc] initWithCapacity:[nameArrays count]];
    [contactInfo setObject:[[NSMutableArray alloc] initWithObjects:@"Phone#", @"david.jpg",  nil] forKey:@"Dlaroue4"];
    [contactInfo setObject:[[NSMutableArray alloc] initWithObjects:@"Phone#", @"zack.jpg",  nil] forKey:@"Zackarious"];
    [contactInfo setObject:[[NSMutableArray alloc] initWithObjects:@"Phone#", @"ethan.jpg",  nil] forKey:@"Ethanry"];
    [contactInfo setObject:[[NSMutableArray alloc] initWithObjects:@"Phone#", @"vince.jpg",  nil] forKey:@"Oe"];
    
    
    
    
    
    
    /*
     Creates a dictionary mapping the section titles (a-z) to arrays containing nameArrays
     This is how we get names ordered under the proper section header
     */
    allSections = [[NSMutableDictionary alloc] initWithCapacity:26];
    for(int i = 0; i < 26; i++) {
        [allSections setObject:[[NSMutableArray alloc]initWithObjects:nil] forKey:[NSNumber numberWithInt:i]];
    }
    for(NSMutableArray *nameArray in nameArrays) {
        NSString *str = [nameArray objectAtIndex:0];
        int asciiOffset = 65;
        int asciiValue = [str characterAtIndex:0];
        int sectionIndex = asciiValue - asciiOffset;
        NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:sectionIndex]];
        [currentSection addObject:nameArray];
    }
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
            NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:sectionIndex]];
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
        allFilteredSections = [tempDic copy];
    }
    [self.tableView reloadData];
}


/*
 Returns the number of existing sections (Those with nil number of rows are excluded in another method)
 */
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return [allSections count];
}


/* 
 Returns the number of rows under each section header in the table view and it takes the 
 search bar being used into account
 */
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    int numRows = 0;
    if (isFiltered) {
        NSMutableArray *currentSection = [allFilteredSections objectForKey:[NSNumber numberWithInt:section]];
        numRows = [currentSection count];
    }else {
        NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:section]];
        numRows = [currentSection count];
    }
    return numRows;
}

/*
 This method helps us name each of the section headers i.e (a-z)
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    int asciiOffset = 65;
    if(isFiltered) {
        return nil;
    }
    NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:section]];
    if([currentSection count] < 1) {
        return nil;
    }else {
        NSString *retString = [NSString stringWithFormat:@"%c", section+asciiOffset];
        return retString;
    }
}


/*
 This method implements the physical features of the cells in the table view
 */
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if(cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    
    if(isFiltered) {
        NSMutableArray *currentFilteredSection = [allFilteredSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentFilteredSection objectAtIndex:indexPath.row];
        cell.cellName.text = [nameArray objectAtIndex:0];
        cell.cellDisplayName.text = [NSString stringWithFormat:@"(%@)", [nameArray objectAtIndex:1]];
        
        NSMutableArray *cellInfo = [contactInfo objectForKey:[nameArray objectAtIndex:1]];
        cell.cellImageView.image = [UIImage imageNamed:[cellInfo objectAtIndex:1]];
        
    }else {
        NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentSection objectAtIndex:indexPath.row];
        cell.cellName.text = [nameArray objectAtIndex:0];
        cell.cellDisplayName.text = [NSString stringWithFormat:@"(%@)", [nameArray objectAtIndex:1]];
        NSMutableArray *cellInfo = [contactInfo objectForKey:[nameArray objectAtIndex:1]];
        cell.cellImageView.image = [UIImage imageNamed:[cellInfo objectAtIndex:1]];
    }
    return cell;
}


/*
 Uses the segue editTheUsualsSegue in order to transfer data from The Usuals to EditVC
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"editTheUsualsSegue" sender:self];
    
}


/*
 Sends message between The Usuals and Edit The Usuals VCs in order to pass data between screens
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditTheUsualsViewController *editVC = segue.destinationViewController;
    
    //Abstracts data needed from args in order to retrieve a cell name and cell display name
    NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt: self.tableView.indexPathForSelectedRow.section]];
    int arrayIndex = self.tableView.indexPathForSelectedRow.row;
    NSMutableArray *nameArray = [currentSection objectAtIndex:arrayIndex];
    NSString *cellName = [nameArray objectAtIndex:0];
    NSString *cellDisplayName = [nameArray objectAtIndex:1];

    //Goes into the cellInfo Dictionary to pass object values to EditVC over the segue
    NSMutableArray *cellInfo = [contactInfo objectForKey:cellDisplayName];
    editVC.nameLabelText = cellName;
    editVC.displayNameLabelText = [NSString stringWithFormat:@"(%@)", cellDisplayName];
    editVC.phoneLabelText = [cellInfo objectAtIndex:0];
    editVC.editImageName = [cellInfo objectAtIndex:1];
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


/* This Chunk of Code Allows for the customization of section headers
 Might use this to make a better distinction between cells and section headers

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
    
    // create the button object
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:20];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    
    // If you want to align the header text as centered
    // headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
    headerLabel.text = @"TESTING"; // i.e. array element
    [customView addSubview:headerLabel];
    
    return customView;
}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
