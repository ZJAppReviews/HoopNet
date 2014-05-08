//
//  LoginSignupViewController.h
//  HoopNet
//
//  Created by David Laroue on 5/7/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginSignupViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *logInUserNameTF;

@property (weak, nonatomic) IBOutlet UITextField *logInPassWordTF;


@property (weak, nonatomic) IBOutlet UIButton *logInButton;


@property (weak, nonatomic) IBOutlet UIButton *signUpButton;


@property (weak, nonatomic) IBOutlet UILabel *loginWarningLabel;





-(IBAction)login:(id)sender;

-(IBAction) goToSignUp:(id)sender;

@end
