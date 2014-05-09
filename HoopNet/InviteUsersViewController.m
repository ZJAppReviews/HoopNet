//
//  InviteUsersViewController.m
//  HoopNet
//
//  Created by Vincent Oe on 5/9/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import "InviteUsersViewController.h"
#import "InviteUsualsTableViewCell.h"

@interface InviteUsersViewController ()

@end

@implementation InviteUsersViewController {
    BOOL isFiltered;
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



- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InviteUsualsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteUsualsCell"];
    if(cell == nil) {
        cell = [[InviteUsualsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"inviteUsualsCell"];
    }
    
    if(isFiltered) {
        NSMutableArray *currentFilteredSection = [self.allFilteredSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentFilteredSection objectAtIndex:indexPath.row];
        cell.userName.text = [nameArray objectAtIndex:0];
        cell.userDisplayName.text = [NSString stringWithFormat:@"(%@)", [nameArray objectAtIndex:1]];
        
        NSMutableArray *cellInfo = [self.contactInfo objectForKey:[nameArray objectAtIndex:1]];
        cell.userImageView.image = [UIImage imageNamed:[cellInfo objectAtIndex:1]];
        
    }else {
        NSMutableArray *currentSection = [self.allSections objectForKey:[NSNumber numberWithInt:indexPath.section]];
        NSMutableArray *nameArray = [currentSection objectAtIndex:indexPath.row];
        cell.userName.text = [nameArray objectAtIndex:0];
        cell.userDisplayName.text = [NSString stringWithFormat:@"(%@)", [nameArray objectAtIndex:1]];
        NSMutableArray *cellInfo = [self.contactInfo objectForKey:[nameArray objectAtIndex:1]];
        cell.userImageView.image = [UIImage imageNamed:[cellInfo objectAtIndex:1]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Add switch logic here
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
