//
//  LoginSignupViewController.m
//  HoopNet
//
//  Created by David Laroue on 5/7/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "LoginSignupViewController.h"

@interface LoginSignupViewController ()

@end

@implementation LoginSignupViewController

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
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self performSegueWithIdentifier:@"homeSegue" sender:nil];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.logInPassWordTF.delegate = self;
    self.logInUserNameTF.delegate = self;
    [self.loginWarningLabel setHidden:YES];
    self.loginWarningLabel.numberOfLines = 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.logInPassWordTF resignFirstResponder];
    [self.logInUserNameTF resignFirstResponder];
    return YES;
}



-(void) login:(id)sender
{
    [self.loginWarningLabel setHidden:YES];
    [PFUser logInWithUsernameInBackground:self.logInUserNameTF.text password:self.logInPassWordTF.text block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            [self performSegueWithIdentifier:@"homeSegue" sender:sender];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [self.loginWarningLabel setHidden:NO];
            self.loginWarningLabel.text = errorString;
            // The login failed. Check error to see why.
        }
    }];
}




-(void) goToSignUp:(id)sender
{
    [self performSegueWithIdentifier:@"signupSegue" sender:sender];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
 
    
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
