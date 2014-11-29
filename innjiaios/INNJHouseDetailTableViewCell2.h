//
//  INNJHouseDetailTableViewCell2.h
//  innjiaios
//
//  Created by wl on 14-11-28.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INNJHouseDetailTableViewCell.h"
@interface INNJHouseDetailTableViewCell2 :INNJHouseDetailTableViewCell
@property (strong, nonatomic) UIButton *favbtn;
@property (strong, nonatomic) IBOutlet UILabel *villagetext;
@property (strong, nonatomic) IBOutlet UILabel *addresstext;
@property (strong, nonatomic) IBOutlet UILabel *infotext;
@property (strong,nonatomic) NSString *houseaid;
@property (strong,nonatomic) NSDictionary *data;
@end