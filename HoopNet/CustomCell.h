//
//  CustomCell.h
//  HoopNet
//
//  Created by David Laroue on 4/17/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell


/*
 Custome objects within a table view cell in The Usuals
 */
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellDisplayName;

@end
