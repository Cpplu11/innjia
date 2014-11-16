//
//  INNJViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJViewController.h"

#import "INNJLoginViewController.h"
@interface INNJViewController ()

@end

@implementation INNJViewController
{
    bool _keyshow;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hud];
    [_hud hide:NO];
    
    _hudtext = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hudtext];
    [_hudtext hide:NO];
    
    self.editView = [self getDoneView:DONEBTNTAG];
    
    //keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
   
}
-(void)viewDidAppear:(BOOL)animated
{
   
    if(self.navigationController)
        self.navigationController.navigationItem.title = self.title;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showLoading
{
    _hud.mode =MBProgressHUDModeIndeterminate;

    [_hud show:YES];
}

-(void) dismissLoading
{
    [_hud hide:YES];
}

-(void) showText:(NSString*) text
{
  
    self.hudtext.mode = MBProgressHUDModeText;
    self.hudtext.labelText = text;
    [_hudtext show:YES];
    __weak id _whudtext =_hudtext;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1* NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_whudtext hide:YES];
    });
    
   
}
-(UIView*) loginView
{
    static UIView *loginview = nil;
    if(loginview==nil)
    {
        loginview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        loginview.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, self.view.width-80, 40)];
        [button setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [loginview addSubview:button];
    }
    
    return loginview;
}

-(UIView*) getDoneView:(NSInteger) tag
{
    UIView* editview = nil;
    if(editview==nil)
    {
        editview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width,40)];
        editview.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [editview addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-60, 12, 40, 16)];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
      
        btn.tag = tag;
        [editview addSubview:btn];
        
    }
    return editview;
}
-(void) loginAction:(id) sender
{
    if(self.navigationController)
    {
        [self performSegueWithIdentifier:@"loginsegue" sender:nil];
    }
}


-(void) keyboardWillShow:(NSNotification*)notification
{
    if(_keyshow)
    {
        return;
    }
  
    CGRect brect = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect erect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat interval = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animation = (UIViewAnimationCurve)[[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIView *editview = [self editView];
    editview.frame = CGRectMake(CGRectGetMinX(brect), CGRectGetMinY(brect)-editview.height, editview.width, editview.height);
    [self.view addSubview:editview];
    [UIView beginAnimations:@"keyshow" context:nil];
    [UIView setAnimationDuration:interval];
    [UIView setAnimationCurve:animation];
    editview.frame = CGRectMake(CGRectGetMinX(erect), CGRectGetMinY(erect)-editview.height, editview.width, editview.height);
    
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification*)notification
{
    if(_keyshow==NO)
        return;
    CGRect erect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat interval = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animation = (UIViewAnimationCurve)[[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIView *editview = [self editView];
    [UIView beginAnimations:@"keyhide" context:nil];
    [UIView setAnimationDuration:interval];
    [UIView setAnimationCurve:animation];
    editview.frame = CGRectMake(CGRectGetMinX(erect), CGRectGetMinY(erect)-editview.height, editview.width, editview.height);
    [UIView commitAnimations];
    [editview removeFromSuperview];
}

-(void) keyboardDidShow:(NSNotification*) notification
{
      _keyshow = YES;
}

-(void) keyboardDidHide:(NSNotification*) notification
{
      _keyshow = NO;
}

-(CGFloat) topoffset
{
    CGFloat offset = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    if(self.navigationController && !self.navigationController.navigationBarHidden)
    {
        offset += self.navigationController.navigationBar.height;
    }
    return offset;
}

-(CGFloat) bottomoffset
{
    if(self.tabBarController && !self.tabBarController.tabBar.hidden)
        return self.tabBarController.tabBar.height;
    return 0;
}
@end
