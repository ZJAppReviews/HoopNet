//
//  EditMyEventViewController.m
//  HoopNet
//
//  Created by Vincent Oe on 5/8/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "EditMyEventViewController.h"
#import "MyEventsViewController.h"

@interface EditMyEventViewController ()

@end

@implementation EditMyEventViewController {
    IBOutlet UILabel *whereLabel;
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
    if (self.currentEvent == nil) {
        
    } else {
        [self.editNameTextField setHidden:YES];
        [self.editLocationTextField setHidden:YES];
        [self.editWhenPicker setHidden:YES];
        
        self.editNameTextField.delegate = self;
        self.editLocationTextField.delegate = self;
        
        //Make it possible to edit the event if you are the organizer
        if ([PFUser currentUser].username == self.currentEvent.organizer) {
            self.navigationItem.rightBarButtonItem = self.editButtonItem;
        }
    }
}

/*
 Functionality for edit button.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing == YES) {
        [self.nameLabel setHidden:YES];
        [whereLabel setHidden:YES];
        [self.locationLabel setHidden:YES];
        [self.dateLabel setHidden:YES];
        [self.timeLabel setHidden:YES];
        [self.editNameTextField setHidden:NO];
        [self.editLocationTextField setHidden:NO];
        [self.editWhenPicker setDate:self.currentEvent.date];
        [self.editWhenPicker setHidden:NO];
        
        self.editNameTextField.text = self.nameLabel.text;
        self.editLocationTextField.text = self.locationLabel.text;
        
    } else {
        [self.nameLabel setHidden:NO];
        [whereLabel setHidden:NO];
        [self.locationLabel setHidden:NO];
        [self.dateLabel setHidden:NO];
        [self.timeLabel setHidden:NO];
        [self.editNameTextField setHidden:YES];
        [self.editLocationTextField setHidden:YES];
        [self.editWhenPicker setHidden:YES];

        //Unwinding segue
        MyEventsViewController* eventViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        NSString *previousName = self.nameLabel.text;
        Event* eventToUpdate;
        int index = -1;
        for(Event *event in eventViewController.eventArray) {
            if([event.name isEqual:previousName]) {
                //Replace oldname with new name in nameArrays
                eventToUpdate = event;
                index = [eventViewController.eventArray indexOfObject:eventToUpdate];
                break;
            }
        }
        if (![self.editNameTextField.text  isEqual: @""]) {
            eventToUpdate.name = self.editNameTextField.text;
            self.nameLabel.text = self.editNameTextField.text;
        }
        if (![self.editLocationTextField.text  isEqual: @""]) {
            eventToUpdate.location = self.editLocationTextField.text;
            self.locationLabel.text = self.editLocationTextField.text;
        }
        NSDate* newDate = self.editWhenPicker.date;
        eventToUpdate.date = newDate;
        
        [eventViewController.eventArray replaceObjectAtIndex:index withObject:eventToUpdate];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        NSString *dateString = [dateFormatter stringFromDate: newDate];
        self.dateLabel.text = dateString;
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"HH:mm";
        NSString *timeString = [timeFormatter stringFromDate: newDate];
        self.timeLabel.text = timeString;
        
        [eventViewController.tableView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.editNameTextField resignFirstResponder];
    [self.editLocationTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
