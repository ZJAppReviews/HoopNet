//
//  EditTheUsualsViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/13/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTheUsualsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property NSString *nameLabelText;


@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property NSString *displayNameLabelText;



@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property NSString *phoneLabelText;


@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property NSString *addressLabelText;



@end
