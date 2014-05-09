//
//  ProfileViewController.m
//  HoopNet
//
//  Created by David Laroue on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    self.displayNameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(homeBUttonPressed:)];
    self.navigationItem.leftBarButtonItem = homeButton;
    
    /*Populate my Profile information*/
    
    PFUser *currentUser = [PFUser currentUser];
    NSString *currentUserName = currentUser[@"username"];
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo:currentUserName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *userObjects, NSError *error) {
        if (!error) {
            for (PFObject *userObject in userObjects) {
                
                /*
                 Setting displayName UI fields from server
                 */
                self.displayNameLabel.text = userObject[@"dname"];
                //self.displayNameTextFieldText = userObject[@"dname"];
                
                /*
                 Setting userName UI fields from server
                 */
                self.userNameWithNoBrackets = userObject[@"username"];
                self.userNameLabel.text = [NSString stringWithFormat:@"(%@)", self.userNameWithNoBrackets];
                
                
                /*
                 Setting phone number UI fields from server
                 */
                self.phoneLabel.text = userObject[@"phone"];
                //self.phoneTextFieldText = userObject[@"phone"];
                
                /*
                 Setting Image from server
                 */
                self.imageHolderText = userObject[@"image"];
                self.imageHolder.image = [UIImage imageNamed:self.imageHolderText];
                
                
                /*
                 Hide Text Fields unless we're editing
                 */
                [self.displayNameTextField setHidden:YES];
                [self.phoneTextField setHidden:YES];
    
                /*
                 Adds edit button at the top right of the EditTheUsualsView
                 */
                self.navigationItem.rightBarButtonItem = self.editButtonItem;
                
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.displayNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
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
        [self.displayNameLabel setHidden:YES];
        [self.phoneLabel setHidden:YES];
        [self.displayNameTextField setHidden:NO];
        [self.phoneTextField setHidden:NO];
        
        self.phoneTextField.text = self.phoneLabel.text;
        self.displayNameTextField.text = self.displayNameLabel.text;
        
    } else {
        BOOL didChange = NO;
        [self.displayNameLabel setHidden:NO];
        [self.phoneLabel setHidden:NO];
        [self.displayNameTextField setHidden:YES];
        [self.phoneTextField setHidden:YES];
        NSString *name = [self.displayNameTextField.text capitalizedString];
        NSString *phone = self.phoneTextField.text;
        
        //Check to see if any changes were made
        if(![name isEqual:self.displayNameLabel.text] || ![phone isEqual:self.phoneLabel.text]) {
            didChange = YES;
        }
        
        self.displayNameLabel.text = name;
        self.phoneLabel.text = phone;
        self.phoneTextField.text = phone;
        self.displayNameTextField.text = name;
        
        //Make Query here to make edits to my profile persistent.
        if(didChange) {
            PFQuery *query= [PFUser query];
            [query whereKey:@"username" equalTo:self.userNameWithNoBrackets];
            [query findObjectsInBackgroundWithBlock:^(NSArray *userObjects, NSError *error) {
                if (!error) {
                    for (PFObject *userObject in userObjects) {
                        [userObject setObject:name forKey:@"dname"];
                        [userObject setObject:phone forKey:@"phone"];
                        [userObject saveInBackground];
                    }
                
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }
}

- (IBAction) homeBUttonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
