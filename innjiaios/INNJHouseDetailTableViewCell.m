//
//  INNJHouseDetailTableViewCell.m
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseDetailTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation INNJHouseDetailTableViewCell
-(void) bindData:(NSDictionary *)data
{}
@end

@implementation INNJHouseDetailTableViewCell1

- (void)awakeFromNib
{
    // Initialization code
    _introtext.adjustsFontSizeToFitWidth = YES;
}
-(void) bindData:(NSDictionary*)data
{
    [_image setImageWithURL:[NSURL URLWithString:HTTPWRAPPER(data[@"image"])]];
    _introtext.text = data[@"intro"];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation INNJHouseDetailTableViewCell2

-(void) awakeFromNib
{

}
-(void) bindData:(NSDictionary *)data
{
    _villagetext.text = [NSString stringWithFormat:@"%@   %@号楼   %@",data[@"village"],data[@"buildingno"],data[@"lease"]];
    _addresstext.text = [NSString stringWithFormat:@"%@ %@",data[@"city"],data[@"district"]];
    _infotext.text = [NSString stringWithFormat:@"%@ %@ %@",data[@"business"],data[@"floor "],data[@"paytype"]];
  
}


@end


@implementation INNJHouseDetailTableViewCell3

-(void) awakeFromNib
{
    
}

-(void) bindData:(NSDictionary *)data
{
    _titletext.text = data[@"title"];
}


@end

@implementation INNJHouseDetailTableViewCell4

-(void)awakeFromNib
{
    
}

-(void)bindData:(NSDictionary *)data
{
    _addresstext.text = data[@"address"];
}

@end