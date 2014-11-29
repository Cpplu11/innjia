//
//  INNJHouseTableViewCell.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "INNJInfoRequest.h"

@interface INNJHouseTableViewCell () <INNJInfoRequestDelegate>

@end
@implementation INNJHouseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _namelabel.adjustsFontSizeToFitWidth = YES;
    _roomlabel.adjustsFontSizeToFitWidth = YES;
    _introlabel.adjustsFontSizeToFitWidth = YES;
    
}
-(void) requestData:(NSInteger) aid
{
    [[INNJInfoRequest request] makeRequest:GetHousebyAid andParams:@{HOUSEAID:@(aid)} andDelegate:self];
}
-(void) bindData:(NSDictionary*) data
{
    //image
    
    [_image setImageWithURL:[NSURL URLWithString:HTTPWRAPPER(data[IMAGEKEY])]];
    _namelabel.text = data[NAMEKEY];
    _pricelabel.text = [NSString stringWithFormat:@"%@元/月",data[PRICEKEY]];
    
    _roomlabel.text = [NSString stringWithFormat:@"%@室%@厅",data[ROOMKEY],data[TINGKEY]];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineHeightMultiple = 1.2;
    NSAttributedString *intro = [[NSAttributedString alloc] initWithString:data[INTROKEY] attributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _introlabel.attributedText = intro;

}
-(void) bindOrignalData:(NSDictionary *)data
{
    [_image setImageWithURL:[NSURL URLWithString:HTTPWRAPPER(data[IMAGEKEY])]];
    _namelabel.text = data[NAMEKEY];
    _pricelabel.text =data[PRICEKEY];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineHeightMultiple = 1.2;
    NSAttributedString *intro = [[NSAttributedString alloc] initWithString:data[INTROKEY] attributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _introlabel.attributedText = intro;
    
    _roomlabel.text = data[ROOMKEY];
}
-(void) bindHouseDate:(HouseDate *)housedate
{
    [_image setImageWithURL:[NSURL URLWithString:HTTPWRAPPER(housedate.img)]];
    _namelabel.text = housedate.village;
    _pricelabel.text = nil;
    _introlabel.text = [NSString stringWithFormat:@"%@室",housedate.shi];
    _roomlabel.text = [NSString stringWithFormat:@"%@元/月",housedate.rent];
}
-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
