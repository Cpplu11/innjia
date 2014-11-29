//
//  INNJDateView.h
//  innjiaios
//
//  Created by wl on 14-11-10.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INNJDateView : UIView
@property (strong, nonatomic) IBOutlet UITextField *nametext;
@property (strong, nonatomic) IBOutlet UIButton *datetextbtn;
@property (strong, nonatomic) IBOutlet UIButton *timetextbtn;

@property (strong, nonatomic) IBOutlet UIButton *contractbtn;
@property (strong, nonatomic) IBOutlet UIButton *submitbtn;
@property (strong, nonatomic) IBOutlet UIView *sexarea;
@property (assign,nonatomic) NSString *sex;
@end
