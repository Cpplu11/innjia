//
//  INNJHouseDetailTableViewCell.h
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INNJHouseDetailTableViewCell : UITableViewCell
-(void) bindData:(NSDictionary*)data;
@end

@interface INNJHouseDetailTableViewCell1 : INNJHouseDetailTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *introtext;

@end

@interface INNJHouseDetailTableViewCell2 :INNJHouseDetailTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *villagetext;
@property (strong, nonatomic) IBOutlet UILabel *addresstext;
@property (strong, nonatomic) IBOutlet UILabel *infotext;
@end

@interface INNJHouseDetailTableViewCell3 : INNJHouseDetailTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titletext;
@property (strong, nonatomic) IBOutlet UILabel *hinttext;

@end

@interface INNJHouseDetailTableViewCell4 : INNJHouseDetailTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *addresstext;
@property (strong, nonatomic) IBOutlet UILabel *distancetext;
@property (strong, nonatomic) IBOutlet UIView *maparea;

@end
