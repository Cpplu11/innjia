//
//  INNJContractViewController.h
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJViewController.h"

@interface INNJContractViewController : INNJViewController
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextView *contracttext;
- (IBAction)submitAction:(id)sender;

@end
