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
@property (strong, nonatomic) IBOutlet UIView *sexarea;
@property (strong, nonatomic) IBOutlet UITextField *teltext;
@property (strong, nonatomic) IBOutlet UITextField *citytext;
@property (strong, nonatomic) IBOutlet UITextField *addresstext;
@property (strong, nonatomic) IBOutlet UITextField *mintext;
@property (strong, nonatomic) IBOutlet UITextField *maxtext;

@property (strong, nonatomic) IBOutlet UIButton *datebtn;
@property (strong, nonatomic) IBOutlet UITextField *requirementstext;
@property (strong, nonatomic) IBOutlet UIButton *submitbutton;
@property (strong, nonatomic) IBOutlet UIView *roomtextarea;


@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *rooms;
@property (nonatomic,strong) NSString *shi;

@property (nonatomic,assign) BOOL sexenable;
@property (nonatomic,assign) BOOL roomsenable;
-(void) bindData:(NSDictionary*) data editable:(BOOL) edit;
@end
