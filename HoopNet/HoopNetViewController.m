//
//  HoopNetViewController.m
//  HoopNet
//
//  Created by David Laroue on 4/11/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "HoopNetViewController.h"

@interface HoopNetViewController ()

@end

@implementation HoopNetViewController


-(void) goToCreateEvents {
    UIStoryboard *createEventsStoryBoard = [UIStoryboard storyboardWithName:@"CreateEventsStoryboard" bundle:nil];
    UIViewController *createEventsVC = [createEventsStoryBoard instantiateInitialViewController];
    createEventsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:createEventsVC animated:YES completion:nil];
}

-(void) goToSearchEvents {
    UIStoryboard *searchEventsStoryBoard = [UIStoryboard storyboardWithName:@"SearchEventsStoryboard" bundle:nil];
    UIViewController *searchEventsVC = [searchEventsStoryBoard instantiateInitialViewController];
    searchEventsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:searchEventsVC animated:YES completion:nil];
}

-(void) goToTheUsuals {
    UIStoryboard *theUsualsStoryBoard = [UIStoryboard storyboardWithName:@"TheUsualsStoryboard" bundle:nil];
    UIViewController *theUsualsVC = [theUsualsStoryBoard instantiateInitialViewController];
    theUsualsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:theUsualsVC animated:YES completion:nil];
}

-(void) goToMyEvents {
    UIStoryboard *myEventsStoryBoard = [UIStoryboard storyboardWithName:@"MyEventsStoryboard" bundle:nil];
    UIViewController *myEventsVC = [myEventsStoryBoard instantiateInitialViewController];
    myEventsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myEventsVC animated:YES completion:nil];
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
