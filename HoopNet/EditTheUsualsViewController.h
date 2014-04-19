//
//  EditTheUsualsViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/13/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTheUsualsViewController : UIViewController

/*
 These are the objects we see after clicking on a table view cell in The Usuals
 */

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property NSString *nameLabelText;

@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property NSString *displayNameLabelText;

@property (weak, nonatomic) IBOutlet UIImageView *editImageVIew;
@property NSString *editImageName;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property NSString *phoneLabelText;





@end
