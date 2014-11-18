//
//  INNJEntrustTableViewCell.h
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DATEKEY @"date"
#define ADDRESSKEY @"address"
#define ROOMKEY @"room"
#define CELLKEY @"entrust"
@interface INNJEntrustTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *datelabel;
@property (strong, nonatomic) IBOutlet UILabel *addresslabel;
@property (strong, nonatomic) IBOutlet UILabel *roomlabel;
-(void) bindData:(NSDictionary*)data;
@end
