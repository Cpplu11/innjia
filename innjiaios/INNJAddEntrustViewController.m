//
//  INNJAddEntrustViewController.m
//  innjiaios
//
//  Created by wl on 14-11-14.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJAddEntrustViewController.h"
#import "INNJEntrustView.h"
#import "INNJInfoRequest.h"
#import "INNJUser.h"
#import <CoreData/CoreData.h>
#import "HouseEntrust.h"
#import "DataManage.h"

#define RESIGNACTION(V) if([V isFirstResponder]) \
    [V resignFirstResponder]
#define DATEDONETAG 312
#define ISTEXTEMPTY(v) (v.text==nil || v.text.length==0)


@interface INNJAddEntrustViewController () <INNJInfoRequestDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) INNJEntrustView *entrustview ;
@property (nonatomic,strong) UIView * datepickerdone;
@property (nonatomic,strong) UIDatePicker *datepicker;
@property (nonatomic,strong) NSDateFormatter* datetimeformatter;
@property (nonatomic,strong) NSString* datetimestr;

@end

@implementation INNJAddEntrustViewController

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
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, self.view.height - self.topoffset-self.bottomoffset)];
    
    [self.view addSubview:_scrollview];
    self.entrustview = [INNJEntrustView getView];
    [_scrollview addSubview:self.entrustview];
    _scrollview.contentSize = CGSizeMake(self.entrustview.width, self.entrustview.height);
    self.navigationItem.title = @"委托找房";
    [(UIButton*)[self.editView viewWithTag:DONEBTNTAG] addTarget:self action:@selector(resignAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_entrustview.datebtn addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_entrustview.submitbutton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    _entrustview.nametext.delegate = _entrustview.addresstext.delegate = _entrustview.citytext.delegate = _entrustview.mintext.delegate = _entrustview.maxtext.delegate = _entrustview.requirementstext.delegate = self;
    
    NSLog(@"%@",NSStringFromUIEdgeInsets(_scrollview.contentInset));
    
    [self initDatePicker];
    _datetimeformatter = [[NSDateFormatter alloc] init];
    [_datetimeformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
   
    if(_showflag)
    {
        [[INNJInfoRequest request] makeRequest:GetEntrustbyId andParams:@{ID:_entrustid,TOKENKEY:[INNJUser user].token} andDelegate:self];
    }
}

-(void) initDatePicker
{
    _datepickerdone  = [self getDoneView:DATEDONETAG];
    _datepickerdone.frame =CGRectMake(0, self.view.height, _datepickerdone.width, _datepickerdone.height);
    _datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    _datepicker.frame = CGRectMake(0, self.view.height+_datepickerdone.height, _datepicker.width, _datepicker.height);
    _datepicker.backgroundColor = [UIColor whiteColor];
    _datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
}

-(void) dateSelect:(id) sender
{
    _datepicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.view.window addSubview:_datepickerdone];
    [self.view.window addSubview:_datepicker];
    [UIView animateWithDuration:0.5 animations:^{
        _datepicker.frame = CGRectMake(0, self.view.height - _datepicker.height, _datepicker.width, _datepicker.height);
        _datepickerdone.frame = CGRectMake(0, _datepicker.top-_datepickerdone.height, _datepickerdone.width,_datepickerdone.height);
    }];
    
    [(UIButton*)[_datepickerdone viewWithTag:DATEDONETAG] addTarget:self action:@selector(dateConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) dateConfirm:(id) sender
{
    [UIView animateWithDuration:0.2 animations:^{
        _datepickerdone.frame =CGRectMake(0, self.view.height, _datepickerdone.width, _datepickerdone.height);
        _datepicker.frame = CGRectMake(0, self.view.height+_datepickerdone.height, _datepicker.width, _datepicker.height);
    } completion:^(BOOL finished) {
        if(finished)
        {
            [_datepickerdone removeFromSuperview];
            [_datepicker removeFromSuperview];
            _datetimestr = [_datetimeformatter stringFromDate:_datepicker.date];
            [_entrustview.datebtn setTitle:_datetimestr forState:UIControlStateNormal];
            
        }
    }];
    
    
}

-(void) resignAction:(id) sender
{
    RESIGNACTION(_entrustview.nametext);
    RESIGNACTION(_entrustview.teltext);
    RESIGNACTION(_entrustview.addresstext);
    RESIGNACTION(_entrustview.mintext);
    RESIGNACTION(_entrustview.maxtext);
    RESIGNACTION(_entrustview.citytext);
    RESIGNACTION(_entrustview.requirementstext);
    [UIView animateWithDuration:1.0 animations:^{
        _scrollview.contentInset = UIEdgeInsetsMake(0, 0,0,0);
    }];
}

-(void) submitAction:(id) sender
{
    if(ISTEXTEMPTY(_entrustview.nametext))
    {
        [self showText:_entrustview.nametext.placeholder];
    }else if(ISTEXTEMPTY(_entrustview.teltext))
    {
        [self showText:_entrustview.teltext.placeholder];
    }else if(ISTEXTEMPTY(_entrustview.addresstext))
    {
        [self showText:_entrustview.addresstext.placeholder];
    }else if(ISTEXTEMPTY(_entrustview.citytext))
    {
        [self showText:_entrustview.citytext.placeholder];
    }else if(ISTEXTEMPTY(_entrustview.mintext))
    {
        [self showText:@"请输入租金期望最低价"];
    }else if(ISTEXTEMPTY(_entrustview.maxtext))
    {
        [self showText:@"请输入租金期望最高价"];
    }else
    {
        [[INNJInfoRequest request] makeRequest:AddEntrust andParams:@{USERNAME:_entrustview.nametext.text,TELEPHONEKEY:_entrustview.teltext.text,USERSEX:_entrustview.sex,USERCITY:_entrustview.citytext.text,HOUSEVILLAGE:_entrustview.addresstext.text,ROOMS:_entrustview.rooms,RENTCOST:[NSString stringWithFormat:@"%@,%@",_entrustview.mintext.text,_entrustview.maxtext.text],CHECKTIME:_datetimestr,MEMO:(ISTEXTEMPTY(_entrustview.requirementstext)? @"":_entrustview.requirementstext.text) ,TOKENKEY:[INNJUser user].token} andDelegate:self];
    }
}

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    if(AddEntrust == type )
    {
        if(AddEntrussSuccessStatus != [data[STATUSKEY] integerValue])
        {
            [self showText:@"添加失败"];
            return;
        }
        [self showText:@"添加成功"];
        HouseEntrust *houseentrust = [NSEntityDescription insertNewObjectForEntityForName:@"HouseEntrust" inManagedObjectContext:[DataManage instance].managedObjectContext];
        houseentrust.date = [NSDate date];
        houseentrust.enid = [NSString stringWithFormat:@"%@",data[@"id"] ] ;
        houseentrust.address = _entrustview.addresstext.text;
        houseentrust.shi = _entrustview.shi;
        [[DataManage instance] saveContext];

        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(GetEntrustbyId == type)
    {
        if(GetEntrustByIdSuccessStatus != [data[STATUSKEY] integerValue])
        {
            [self showText:@"不可以得到委托"];
            return;
        }

        [_entrustview bindData:data[@"data"] editable:NO];
    }
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(!_showflag)
    {
        CGRect rect = textField.frame;
        CGFloat offset =  180 - CGRectGetMinY(rect);
        if(offset <0)
        {
            [UIView animateWithDuration:1.0 animations:^{
                _scrollview.contentInset = UIEdgeInsetsMake(offset, 0,0,0);
            }];
        }
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(!_showflag)
    {
        
        [UIView animateWithDuration:1.0 animations:^{
        _scrollview.contentInset = UIEdgeInsetsMake(0, 0,0,0);
        }];
        [textField resignFirstResponder];
    }
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

@end
