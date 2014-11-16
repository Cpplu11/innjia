//
//  INNJHouseTableViewCell.h
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGEKEY @"img"
#define NAMEKEY @"village"
#define PRICEKEY @"rent"
#define INTROKEY @"subject"
#define ROOMKEY @"shi"
#define TINGKEY @"ting"

#define CELLKEY @"HouseTableViewCell"
@interface INNJHouseTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *namelabel;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UILabel *introlabel;
@property (strong, nonatomic) IBOutlet UILabel *roomlabel;
-(void) bindData:(NSDictionary*) data;
@end
