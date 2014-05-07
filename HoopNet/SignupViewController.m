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
    [self.uNameWarning setHidden:YES];
    [self.dNameWarning setHidden:YES];
    [self.pWordWarning setHidden:YES];
    // Do any additional setup after loading the view.
    
}

-(void) addNewUser:(id)sender
{
    BOOL errorExist = NO;
    NSString *dName = self.signUpDisplayNameTF.text;
    NSString *uName = self.signUpUserNameTF.text;
    NSString *pWord = self.signupPasswordTF.text;
    if([dName isEqualToString:nil] || [dName length] < 5) {
        [self.dNameWarning setHidden:NO];
        errorExist = YES;
    }
    if([uName isEqualToString:nil] || [uName length] < 5) {
        [self.uNameWarning setHidden:NO];
        errorExist = YES;
    }
    if([pWord isEqualToString:nil] || [pWord length] < 5) {
        [self.pWordWarning setHidden:NO];
        errorExist = YES;
    }
    if(!errorExist) {
        [self.uNameWarning setHidden:YES];
        [self.dNameWarning setHidden:YES];
        [self.pWordWarning setHidden:YES];
    }
    
    if(!errorExist) {
        PFObject *newUser = [PFObject objectWithClassName:@"User"];
        newUser[@"dName"] = dName;
        newUser[@"uName"] = uName;
        newUser[@"pWord"] = pWord;
        [newUser saveInBackground];
        [self performSegueWithIdentifier:@"signinSegue" sender:sender];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.signUpDisplayNameTF resignFirstResponder];
    [self.signUpUserNameTF resignFirstResponder];
    [self.signupPasswordTF resignFirstResponder];
    return YES;
}


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
