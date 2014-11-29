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
@property (nonatomic,strong) NSString * token;
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
    
    if(self.navigationController)
        self.navigationItem.title = @"登录";
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


-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    //NSLog(@"%@",data);
    
 
    
    if(CheckMobile == type)
    {
        
        if(VerifySuccessStatus == [[data objectForKey:STATUSKEY] integerValue])
        {
            
            [[INNJUser user] login:_telephonetext.text andToken:_token];
           
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
            _token = data[TOKENKEY];
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
    if(_telephonetext.text!=nil && _telephonetext.text.length>0)
    {
        self.hud.labelText = @"正在登录";
        [self showLoading];
        [[INNJInfoRequest request] makeRequest:CheckMobile andParams:@{TELEPHONEKEY:_telephonetext.text,VERIFYKEY:_codetext.text,TOKENKEY:_token} andDelegate:self];
    }else
    {
       [self showText:@"手机和验证码不许为空"];
        
    }
}
@end
