//
//  SignupViewController.m
//  HoopNet
//
//  Created by David Laroue on 5/7/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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
    self.signupPasswordTF.delegate = self;
    self.signUpDisplayNameTF.delegate = self;
    self.signUpUserNameTF.delegate = self;
    self.signupPhoneTF.delegate = self;
    self.signupEmailTF.delegate = self;
    self.signupConfirmPWordTF.delegate = self;
    self.signUpWarningLabel.numberOfLines = 0;
    
    [self.signUpWarningLabel setHidden:YES];
    
    
    // Do any additional setup after loading the view.
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.signUpDisplayNameTF resignFirstResponder];
    [self.signUpUserNameTF resignFirstResponder];
    [self.signupPasswordTF resignFirstResponder];
    [self.signupEmailTF resignFirstResponder];
    [self.signupPhoneTF resignFirstResponder];
    [self.signupConfirmPWordTF resignFirstResponder];
    return YES;
}


- (void)addNewUser:(id)sender{
    [self.signUpWarningLabel setHidden:YES];
    PFUser *user = [PFUser user];
    user.username = self.signUpUserNameTF.text;
    user.password = self.signupPasswordTF.text;
    if(![self.signupEmailTF.text isEqualToString:@""]) {
        user.email = self.signupEmailTF.text;
    }
    if(![self.signupPhoneTF.text isEqualToString:@""]) {
        user[@"phone"] = self.signupPhoneTF.text;
    }
    
    
    // other fields can be set just like with PFObject
    
    user[@"dname"] = self.signUpDisplayNameTF.text;
    
    if([self.signUpDisplayNameTF.text isEqualToString:@""]){
        [self.signUpWarningLabel setHidden:NO];
        self.signUpWarningLabel.text = @"Must have a Display Name";
    }else if([self.signUpUserNameTF.text isEqualToString:@""]) {
        [self.signUpWarningLabel setHidden:NO];
        self.signUpWarningLabel.text = @"Must have a User Name";
    }else if([self.signupPasswordTF.text isEqualToString:@""]) {
        [self.signUpWarningLabel setHidden:NO];
        self.signUpWarningLabel.text = @"Must have a Password";
    }else if(![self.signupConfirmPWordTF.text isEqualToString:self.signupPasswordTF.text]) {
        [self.signUpWarningLabel setHidden:NO];
        self.signUpWarningLabel.text = @"Passwords don't match";
    }else {
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                
                //PFUser *currentUser = [PFUser currentUser];
                [self performSegueWithIdentifier:@"homeSegue" sender:sender];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                [self.signUpWarningLabel setHidden:NO];
                self.signUpWarningLabel.text = errorString;
            
                // Show the errorString somewhere and let the user try again.
            }
        }];
    }
}


-(void)goToLogin:(id)sender {
    [self performSegueWithIdentifier:@"signinSegue" sender:sender];
}



//Used to slide view when keyboard pops up
/*
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
*/
// Sliding Text fields end here


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"signinSegue"]) {
        // Pass any values through segue
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
