//
//  INNJHouseTableViewCell.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation INNJHouseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
  
}

-(void) bindData:(NSDictionary*) data
{
    //image
    [_image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",data[IMAGEKEY]]]];
    _namelabel.text = data[NAMEKEY];
    _pricelabel.text = [NSString stringWithFormat:@"%@元/月",data[PRICEKEY]];
    _introlabel.text = data[INTROKEY];
    _roomlabel.text = [NSString stringWithFormat:@"%@室%@厅",data[ROOMKEY],data[TINGKEY]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
