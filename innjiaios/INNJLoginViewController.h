//
//  INNJLoginViewController.h
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INNJViewController.h"
#import "INNJInfoRequest.h"

@interface INNJLoginViewController : INNJViewController
@property (strong, nonatomic) IBOutlet UITextField *telephonetext;
@property (strong, nonatomic) IBOutlet UITextField *codetext;
@property (strong, nonatomic) IBOutlet UIButton *codebtn;
@property (strong, nonatomic) IBOutlet UIButton *loginbtn;
- (IBAction)codeAction:(id)sender;
- (IBAction)loginAction:(id)sender;
-(void) doneAction:(id)sender;

@end
