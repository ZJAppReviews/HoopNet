//
//  EditTheUsualsViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/13/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "EditTheUsualsViewController.h"

@interface EditTheUsualsViewController ()

@end

@implementation EditTheUsualsViewController

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
    
    /*
     Initializing all objects In the Contact Info View
     */
    self.nameLabel.text = self.nameLabelText;
    self.displayNameLabel.text = self.displayNameLabelText;
    self.phoneLabel.text = self.phoneLabelText;
    self.editImageVIew.image = [UIImage imageNamed:self.editImageName];
    
    /*
     Adds edit button at the top right of the EditTheUsualsView
     */
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 Functionality for edit button.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing == YES)
    {
        NSLog(@"ENTERING EDIT MODE");
    } else {
        NSLog(@"LEAVING EDIT MODE");
    }
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
