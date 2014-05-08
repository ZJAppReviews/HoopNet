//
//  TheUsualsCustomCell.h
//  HoopNet
//
//  Created by Vincent Oe on 5/7/14.
//  Copyright (c) 2014 David Laroue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheUsualsCustomCell : UITableViewCell

/*
 Custome objects within a table view cell in The Usuals
 */
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellDisplayName;

@end