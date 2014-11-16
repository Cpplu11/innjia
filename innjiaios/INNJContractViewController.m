//
//  INNJContractViewController.m
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJContractViewController.h"
#import "INNJAddDateViewController.h"
@interface INNJContractViewController ()

@end

@implementation INNJContractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_submitBtn setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    self.navigationItem.title = @"看房协议";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


- (IBAction)submitAction:(id)sender {
    INNJAddDateViewController *controller =[[INNJAddDateViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
