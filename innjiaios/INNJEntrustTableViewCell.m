//
//  INNJEntrustTableViewCell.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJEntrustTableViewCell.h"

@implementation INNJEntrustTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _datelabel.adjustsFontSizeToFitWidth = YES;
    _addresslabel.adjustsFontSizeToFitWidth = YES;
    _roomlabel.adjustsFontSizeToFitWidth = YES;
}

-(void) bindData:(NSDictionary*)data
{
    _datelabel.text = data[DATEKEY];
    _addresslabel.text = data[ADDRESSKEY];
    _roomlabel.text = data[ROOMKEY];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
