//
//  TheUsualsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "TheUsualsViewController.h"
#import "EditTheUsualsViewController.h"

@interface TheUsualsViewController ()
{
    NSMutableDictionary *allSections;
    NSMutableArray *nameArrays;
    NSMutableDictionary *contactInfo;
    NSMutableDictionary *allFilteredSections;
    BOOL isFiltered;
    
    
    // MAYBE DELETE THIS
    NSMutableArray *info;
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
    
    
    
    
    nameArrays = [[NSMutableArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"David Laroue", @"Dlaroue4", nil],[[NSArray alloc] initWithObjects:@"Vince Oe", @"Poonany", nil], [[NSArray alloc] initWithObjects:@"Ethan Lewis", @"Ethanry", nil], [[NSArray alloc] initWithObjects:@"Zack Winchester", @"Zackarious", nil], [[NSArray alloc] initWithObjects:@"Daniel Something", @"Weirdo", nil], nil];

    contactInfo = [[NSMutableDictionary alloc] initWithCapacity:[nameArrays count]];
    
    info  = [[NSMutableArray alloc] initWithObjects:@"(323)-485-0292", @"931 S Ford Blvd",  nil];
    
    for(NSMutableArray *nameArray in nameArrays) {
        NSString *displayName = [nameArray objectAtIndex:1];
        NSLog(@"ADDING TO CONTACT INFO");
        
        [contactInfo setObject:info forKey:displayName];
    }
    
    
    
    
    
    
    
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

/*DONE*/
- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar {
    [searchBar setShowsCancelButton: YES animated: YES];
}

/*DONE*/
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isFiltered = NO;
    [self.tableView reloadData];
    searchBar.text = @"";
    [searchBar setShowsCancelButton: NO animated: NO];
    [searchBar resignFirstResponder];
    
}


/* Done */
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton: NO animated: NO];
    [self.searchBar resignFirstResponder];
    
}



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
        //[self.tableView.dataSource tableView:self.tableView titleForFooterInSection:0];
        
        
    }
    [self.tableView reloadData];
}


/* Done */
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return [allSections count];
}


/* Done */
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    int numRows = 0;
    //Should be number of names with people who fall under the given section.
    if (isFiltered) {
        NSMutableArray *currentSection = [allFilteredSections objectForKey:[NSNumber numberWithInt:section]];
        numRows = [currentSection count];
    }else {
        NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:section]];
        numRows = [currentSection count];
    }
    return numRows;
}

/* Done */
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



- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    
    if(isFiltered) {
        NSMutableArray *currentFilteredSection = [allFilteredSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentFilteredSection objectAtIndex:indexPath.row];
        cell.textLabel.text = [nameArray objectAtIndex:0];
    }else {
        NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentSection objectAtIndex:indexPath.row];
        cell.textLabel.text = [nameArray objectAtIndex:0];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //STOPPED HERE
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //EditTheUsualsViewController *editVC = [[EditTheUsualsViewController alloc] init];
    //[self.navigationController pushViewController:editVC animated:YES];
    //NSLog(@"indexPath %@", indexPath);
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"editTheUsualsSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    EditTheUsualsViewController *editVC = segue.destinationViewController;
    NSMutableArray *currentSection = [allSections objectForKey:[NSNumber numberWithInt: self.tableView.indexPathForSelectedRow.section]];
    int arrayIndex = self.tableView.indexPathForSelectedRow.row;
    NSMutableArray *nameArray = [currentSection objectAtIndex:arrayIndex];
    NSString *cellName = [nameArray objectAtIndex:0];
    NSString *cellDisplayName = [nameArray objectAtIndex:1];

    NSMutableArray *cellInfo = [contactInfo objectForKey:cellDisplayName];
    
    editVC.nameLabelText = cellName;
    editVC.displayNameLabelText = cellDisplayName;
    editVC.phoneLabelText = [cellInfo objectAtIndex:0];
    editVC.addressLabelText = [cellInfo objectAtIndex:1];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Unselect the selected row if any
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
