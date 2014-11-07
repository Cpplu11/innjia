//
//  INNJMineTableViewCell.m
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJMineTableViewCell.h"

@implementation INNJMineTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
}

-(void) addData:(NSString*) imageName andTitle:(NSString*) title
{
    [_image setImage:[UIImage imageNamed:imageName]];
    [_title setText:title];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
