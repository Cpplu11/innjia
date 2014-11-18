//
//  INNJLoginViewController.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJLoginViewController.h"
#import "INNJUser.h"
@interface INNJLoginViewController () <UITextFieldDelegate,INNJInfoRequestDelegate>

@end

@implementation INNJLoginViewController

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
 
    _telephonetext.background = _codetext.background = SCBGIMAGEOFF;
    PADDINGDEFAULT(_telephonetext);
    PADDINGDEFAULT(_codetext);
    _telephonetext.delegate = _codetext.delegate = self;
    [_codebtn setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    [_loginbtn setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    [(UIButton*)[[self editView] viewWithTag:DONEBTNTAG] addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) doneAction:(id)sender
{
    [_codetext resignFirstResponder];
    [_telephonetext resignFirstResponder];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    NSLog(@"%@",data);
    
    //测试
//    [[INNJUser user] login:_telephonetext.text];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINNOTIFICATION object:nil];
//    [self.navigationController popViewControllerAnimated:YES];
//    return;
    
    if(CheckMobile == type)
    {
        
        if(VerifySuccessStatus == [[data objectForKey:STATUSKEY] integerValue])
        {
            
            [[INNJUser user] login:_telephonetext.text];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGINNOTIFICATION object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self showText:@"验证码错误"];
        }
    }else if(StepMobile == type)
    {
        if(StepSuccessStatus == [[data objectForKey:STATUSKEY] integerValue])
        {
            [self showText:@"验证码发送成功"];
        }else
        {
            [self showText:@"验证码发送出错"];
        }
    }
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    [self dismissLoading];
    [self showText:@"服务器错误,请稍后再试"];
}

- (IBAction)codeAction:(id)sender {
    
    
    if(_telephonetext.text!=nil && _telephonetext.text.length>0)
    {
        self.hud.labelText = @"正在发送验证码";
        [self showLoading];
        [[INNJInfoRequest request] makeRequest:StepMobile andParams:@{TELEPHONEKEY:_telephonetext.text} andDelegate:self];
    }else
    {
      
        [self showText:@"手机不许为空"];
        
    }
}

- (IBAction)loginAction:(id)sender {
    if(_telephonetext.text!=nil && _telephonetext.text.length>0&& _codetext.text!=nil && _codetext.text.length>0)
    {
        self.hud.labelText = @"正在登录";
        [self showLoading];
        [[INNJInfoRequest request] makeRequest:StepMobile andParams:@{TELEPHONEKEY:_telephonetext.text,VERIFYKEY:_codetext.text} andDelegate:self];
    }else
    {
       [self showText:@"手机和验证码不许为空"];
        
    }
}
@end
