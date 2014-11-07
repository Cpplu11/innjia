//
//  INNJMineTableViewCell.h
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IDENTIFIER @"INNJMineTableViewCell"
@interface INNJMineTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;
-(void) addData:(NSString*) imageName andTitle:(NSString*) title;
@end
