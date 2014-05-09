//
//  ProfileViewController.h
//  HoopNet
//
//  Created by David Laroue on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *displayNameTextField;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property NSString *userNameWithNoBrackets;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property NSString *imageHolderText;








@end
