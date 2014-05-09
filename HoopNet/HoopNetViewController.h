//
//  HoopNetViewController.h
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface HoopNetViewController : UIViewController

/*
 Button methods on home page leading to each of the four story boards
 */
-(IBAction)goToCreateEvents;
-(IBAction)goToSearchEvents;
-(IBAction)goToTheUsuals;
-(IBAction)goToMyEvents;



@property (weak, nonatomic) IBOutlet UIButton *logoutButton;



-(IBAction)logOut:(id)sender;
-(IBAction)toProfile:(id)sender;


@end
