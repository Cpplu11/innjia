//
//  INNJEntrustView.h
//  innjiaios
//
//  Created by wl on 14-11-10.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INNJEntrustView : UIView
@property (strong, nonatomic) IBOutlet UITextField *nametext;
@property (strong, nonatomic) IBOutlet UITextField *teltext;
@property (strong, nonatomic) IBOutlet UITextField *addresstext;
@property (strong, nonatomic) IBOutlet UITextField *mintext;
@property (strong, nonatomic) IBOutlet UITextField *maxtext;
@property (strong, nonatomic) IBOutlet UITextField *datetext;
@property (strong, nonatomic) IBOutlet UITextField *requirementstext;
@property (strong, nonatomic) IBOutlet UIButton *submitbutton;
@property (strong, nonatomic) IBOutlet UIView *roomtextarea;

@end
