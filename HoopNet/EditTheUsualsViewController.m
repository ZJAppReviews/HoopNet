//
//  EditTheUsualsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/13/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "EditTheUsualsViewController.h"
#import "TheUsualsViewController.h"

@interface EditTheUsualsViewController ()

@end

@implementation EditTheUsualsViewController

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
    
    self.editNameTextField.delegate = self;
    self.editPhoneTextField.delegate = self;
    
    /*
     Initializing all objects In the Contact Info View
     */
    self.nameLabel.text = self.nameLabelText;
    self.displayNameLabel.text = self.displayNameLabelText;
    self.phoneLabel.text = self.phoneLabelText;
    self.editImageVIew.image = [UIImage imageNamed:self.editImageName];
    [self.editNameTextField setHidden:YES];
    [self.editPhoneTextField setHidden:YES];
    
    /*
     Adds edit button at the top right of the EditTheUsualsView
     */
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.editPhoneTextField resignFirstResponder];
    [self.editNameTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 Functionality for edit button.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing == YES)
    {
        [self.nameLabel setHidden:YES];
        [self.phoneLabel setHidden:YES];
        [self.editNameTextField setHidden:NO];
        [self.editPhoneTextField setHidden:NO];
        
        self.editPhoneTextField.text = self.phoneTextFieldText;
        self.editNameTextField.text = self.nameTextFieldText;
        
    } else {
        [self.nameLabel setHidden:NO];
        [self.phoneLabel setHidden:NO];
        [self.editNameTextField setHidden:YES];
        [self.editPhoneTextField setHidden:YES];
        NSString *name = [self.editNameTextField.text capitalizedString];
        NSString *phone = self.editPhoneTextField.text;
        
        //Unwinding segue
        TheUsualsViewController *theUsualsVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        int indexToReplace = -1;
        
        NSString *displayName = self.displayNameLabel.text;
        NSRange range = NSMakeRange (1, displayName.length-2);
        NSString *cleanDisplayName = [displayName substringWithRange:range];
        for(NSMutableArray *nameArray in theUsualsVC.nameArrays) {
            if([[nameArray objectAtIndex: 1] isEqual:cleanDisplayName]) {
                //Replace oldname with new name in nameArrays
                indexToReplace = [theUsualsVC.nameArrays indexOfObject:nameArray];
                break;
            }
        }
        [theUsualsVC.nameArrays replaceObjectAtIndex:indexToReplace withObject:[[NSMutableArray alloc] initWithObjects:name, cleanDisplayName, nil]];
        //Replace oldphone with phone in contactInfo with key cleanDisplayName
        NSMutableArray *cinfo = [theUsualsVC.contactInfo objectForKey:cleanDisplayName];
        [cinfo replaceObjectAtIndex:0 withObject:phone];
        [self.editPhoneTextField resignFirstResponder];
        [self.editNameTextField resignFirstResponder];
        //NSString *phoneBeforeEdit = self.phoneLabel.text;
        //NSString *nameBeforeEdit = self.nameLabel.text;
        self.nameLabel.text = name;
        self.phoneLabel.text = phone;
        self.phoneTextFieldText = phone;
        self.nameTextFieldText = name;
        
        [theUsualsVC refreshAllSections];
        
        //Make changes to allFilteredSections results show from searchBar filter
        NSString *searchText = theUsualsVC.searchBar.text;
        [theUsualsVC searchBar:theUsualsVC.searchBar textDidChange: searchText];
        
        
    }
}




//////// This is a query to update editing to the server and make it persistent

/*
 
 if(![nameBeforeEdit isEqualToString:name] || ![phoneBeforeEdit isEqualToString:phone]) {
 PFQuery *query= [PFUser query];
 [query whereKey:@"username" equalTo:cleanDisplayName];
 [query findObjectsInBackgroundWithBlock:^(NSArray *userObjects, NSError *error) {
 if (!error) {
 for (PFObject *userObject in userObjects) {
 NSLog(@"Successfully retrieved %d scores.", userObjects.count);
 [userObject setObject:name forKey:@"dname"];
 [userObject setObject:phone forKey:@"phone"];
 }
 
 } else {
 NSLog(@"Error: %@ %@", error, [error userInfo]);
 }
 }];
 }
 */

/////////////////
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
