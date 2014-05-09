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

@implementation EditMyEventViewController

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
        self.nameLabel.text = self.currentEvent.name;
        self.locationLabel.text = self.currentEvent.location;
        self.organizerLabel.text = self.currentEvent.organizer;
        NSDate* dateInfo = self.currentEvent.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        NSString *dateString = [dateFormatter stringFromDate: dateInfo];
        self.dateLabel.text = dateString;
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"HH:mm";
        NSString *timeString = [timeFormatter stringFromDate: dateInfo];
        self.timeLabel.text = timeString;
        
        [self.editNameTextField setHidden:YES];
        [self.editLocationTextField setHidden:YES];
        [self.editWhenPicker setHidden:YES];
        
        //Make it possible to edit the event if you are the organizer
        //if ([PFUser currentUser].username == self.currentEvent.organizer) {
            // place the edit button
        //    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setEditing:)];
        //    self.navigationItem.rightBarButtonItem  = editButton;
        //}
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
        [self.locationLabel setHidden:YES];
        [self.dateLabel setHidden:YES];
        [self.timeLabel setHidden:YES];
        [self.editNameTextField setHidden:NO];
        [self.editLocationTextField setHidden:NO];
        
        self.editNameTextField.text = self.nameLabel.text;
        self.editLocationTextField.text = self.locationLabel.text;
        
    } else {
        [self.nameLabel setHidden:NO];
        [self.locationLabel setHidden:NO];
        [self.editNameTextField setHidden:YES];
        [self.editLocationTextField setHidden:YES];
        
        //Unwinding segue
        MyEventsViewController* eventViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        NSString *previousName = self.nameLabel.text;
        NSRange range = NSMakeRange (1, previousName.length-2);
        NSString *cleanPreviousName = [previousName substringWithRange:range];
        Event* eventToUpdate;
        for(Event *event in eventViewController.eventArray) {
            if([event.name isEqual:cleanPreviousName]) {
                //Replace oldname with new name in nameArrays
                eventToUpdate = event;
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
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        NSString *dateString = [dateFormatter stringFromDate: newDate];
        self.dateLabel.text = dateString;
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"HH:mm";
        NSString *timeString = [timeFormatter stringFromDate: newDate];
        self.timeLabel.text = timeString;
        
        [eventViewController refreshAllSections];
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
