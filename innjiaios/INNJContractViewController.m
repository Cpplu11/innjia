//
//  INNJContractViewController.m
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJContractViewController.h"
#import "INNJAddDateViewController.h"
#import "INNJUser.h"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:LOGOUTNITIFICATION object:nil];
    
    
    //登出状态
    self.loginView.frame = CGRectMake((self.view.width - self.loginView.width)/2, (self.view.height - self.loginView.height)/2, self.loginView.width, self.loginView.height);
    [self.view addSubview:self.loginView];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self initUI:[[INNJUser user] isLogin]];
}

-(void) login:(NSNotification*) notification
{
    [self initUI:YES];
}

-(void) logout:(NSNotification*) notification
{
    [self initUI:NO];
}

-(void) initUI:(BOOL) islogin
{
    if(islogin)
    {
        [self.loginView removeFromSuperview];
        if(_contracttext.superview == nil)
        {
            [self.view addSubview:_contracttext];
        }
        if(_submitBtn.superview == nil)
        {
            [self.view addSubview:_submitBtn];
        }
        
    }else
    {
        [_contracttext removeFromSuperview];
        [_submitBtn removeFromSuperview];
        if(self.loginView.superview==nil)
        {
            [self.view addSubview:self.loginView];
        }
    }
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
