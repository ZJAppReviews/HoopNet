//
//  SignupViewController.h
//  HoopNet
//
//  Created by David Laroue on 5/7/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignupViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *signUpDisplayNameTF;

@property (weak, nonatomic) IBOutlet UITextField *signUpUserNameTF;

@property (weak, nonatomic) IBOutlet UITextField *signupPasswordTF;


@property (weak, nonatomic) IBOutlet UITextField *signupEmailTF;


@property (weak, nonatomic) IBOutlet UITextField *signupPhoneTF;


@property (weak, nonatomic) IBOutlet UITextField *signupConfirmPWordTF;



@property (weak, nonatomic) IBOutlet UIButton *finishSignUpButton;

@property (weak, nonatomic) IBOutlet UIButton *backToLoginButton;



-(IBAction)addNewUser:(id)sender;

-(IBAction)goToLogin:(id)sender;



// Warning Labels

@property (weak, nonatomic) IBOutlet UILabel *signUpWarningLabel;



@end
