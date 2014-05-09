//
//  CreateEventsViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField* eventNameField;

@property (weak, nonatomic) IBOutlet UITextField* eventLocationField;

@property (weak, nonatomic) IBOutlet UIDatePicker* eventDatePicker;

-(IBAction)checkAndForward:(id)sender;

@end
