//
//  CreateEventsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "CreateEventsViewController.h"
#import "InviteUsersViewController.h"

@interface CreateEventsViewController ()

@end

@implementation CreateEventsViewController {
    IBOutlet UIButton* nextButton;
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* locationLabel;
}

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
    [self.eventDatePicker setDate:[[NSDate alloc] init]];
    self.eventNameField.delegate = self;
    self.eventLocationField.delegate = self;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

/*
 takes you back to the home page
 */
- (IBAction) cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)checkAndForward:(id)sender {
    NSLog(@"HELL YA");
    BOOL ready = true;
    
    if ([self.eventNameField.text isEqual:@""]) {
        ready = false;
        nameLabel.text = @"Please insert event name";
        nameLabel.textColor = [UIColor redColor];
    } else {
        ready = true;
        nameLabel.text = @"event name";
        nameLabel.textColor = [UIColor blackColor];
    }
    if ([self.eventLocationField.text isEqual:@""]) {
        ready = false;
        locationLabel.text = @"Please insert event location";
        locationLabel.textColor = [UIColor redColor];
    } else {
        ready = true;
        locationLabel.text = @"event name";
        locationLabel.textColor = [UIColor blackColor];
    }
    
    if (ready) {
        [self performSegueWithIdentifier:@"inviteUsualsSegue" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"inviteUsualsSegue"]) {
        InviteUsersViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.eventName = self.eventNameField.text;
        destinationViewController.eventLocation = self.eventLocationField.text;
        destinationViewController.eventDate = self.eventDatePicker.date;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.eventNameField resignFirstResponder];
    [self.eventLocationField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
