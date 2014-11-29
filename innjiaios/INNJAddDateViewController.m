//
//  INNJAddDateViewController.m
//  innjiaios
//
//  Created by wl on 14-11-14.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJAddDateViewController.h"
#import "INNJDateView.h"
#import "INNJInfoRequest.h"
#import "INNJUser.h"
#import "DataManage.h"
#import "HouseDate.h"
#import <CoreData/CoreData.h>

#define DATEDONETAG 1231
@interface INNJAddDateViewController ()<INNJInfoRequestDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) INNJDateView *dateview ;
@property (nonatomic,strong) UIView * datepickerdone;
@property (nonatomic,strong) UIDatePicker *datepicker;
@property (nonatomic,strong) NSDateFormatter* dateformatter;
@property (nonatomic,strong) NSDateFormatter* timeformatter;
@property (nonatomic,strong) NSString* datestr;
@property (nonatomic,strong) NSString* timestr;
@end

@implementation INNJAddDateViewController

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
    self.dateview = [INNJDateView getView];
    [_scrollview addSubview:self.dateview];
    _scrollview.contentSize = CGSizeMake(self.dateview.width, self.dateview.height);
    self.navigationItem.title = @"预约看房";
    
    [(UIButton*)[self.editView viewWithTag:DONEBTNTAG] addTarget:self action:@selector(resignAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateview.datetextbtn addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateview.timetextbtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateview.submitbtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateview.contractbtn addTarget:self action:@selector(contractAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initDatePicker];
    _dateformatter = [[NSDateFormatter alloc] init];
    [_dateformatter setDateFormat:@"yyyy-MM-dd"];
    _timeformatter = [[NSDateFormatter alloc] init];
    [_timeformatter setDateFormat:@"HH:mm"];
    
    
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
-(void) resignAction:(id) sender
{
    [_dateview.nametext resignFirstResponder];
}

-(void) dateSelect:(id) sender
{
    _datepicker.datePickerMode = UIDatePickerModeDate;
    [self.view.window addSubview:_datepickerdone];
    [self.view.window addSubview:_datepicker];
    [UIView animateWithDuration:0.5 animations:^{
        _datepicker.frame = CGRectMake(0, self.view.height - _datepicker.height, _datepicker.width, _datepicker.height);
        _datepickerdone.frame = CGRectMake(0, _datepicker.top-_datepickerdone.height, _datepickerdone.width,_datepickerdone.height);
    }];
    
    [(UIButton*)[_datepickerdone viewWithTag:DATEDONETAG] addTarget:self action:@selector(dateConfirm:) forControlEvents:UIControlEventTouchUpInside];

}

-(void) timeSelect:(id) sender
{
    _datepicker.datePickerMode = UIDatePickerModeTime;
    [self.view.window addSubview:_datepickerdone];
    [self.view.window addSubview:_datepicker];
    [UIView animateWithDuration:0.5 animations:^{
        _datepicker.frame = CGRectMake(0, self.view.height - _datepicker.height, _datepicker.width, _datepicker.height);
        _datepickerdone.frame = CGRectMake(0, _datepicker.top-_datepickerdone.height, _datepickerdone.width,_datepickerdone.height);
    }];
    
    [(UIButton*)[_datepickerdone viewWithTag:DATEDONETAG] addTarget:self action:@selector(timeConfirm:) forControlEvents:UIControlEventTouchUpInside];
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
            _datestr = [_dateformatter stringFromDate:_datepicker.date];
            [_dateview.datetextbtn setTitle:_datestr forState:UIControlStateNormal];
            
        }
    }];
    
    
}


-(void) timeConfirm:(id) sender
{
    
    [UIView animateWithDuration:0.2 animations:^{
        _datepickerdone.frame =CGRectMake(0, self.view.height, _datepickerdone.width, _datepickerdone.height);
        _datepicker.frame = CGRectMake(0, self.view.height+_datepickerdone.height, _datepicker.width, _datepicker.height);
    } completion:^(BOOL finished) {
        if(finished)
        {
            [_datepickerdone removeFromSuperview];
            [_datepicker removeFromSuperview];
            _timestr = [_timeformatter stringFromDate:_datepicker.date];
            [_dateview.timetextbtn setTitle:_timestr forState:UIControlStateNormal];
            
        }
    }];
    
}
-(void) submitAction:(id) sender
{
    if(_dateview.nametext.text == nil || _dateview.nametext.text.length ==0)
    {
        [self showText:@"请填写姓名"];
    }else if(_datestr==nil || _timestr ==nil)
    {
        [self showText:@"请填写预约日期和时间"];
    }else
    {
        NSString *datetimestr = [NSString stringWithFormat:@"%@ %@",_datestr,_timestr];
        [[INNJInfoRequest request] makeRequest:AddPredict andParams:@{USERNAME:_dateview.nametext.text,USERSEX:_dateview.sex,USERDATE:datetimestr,HOUSEAID:[INNJUser user].currentid,TOKENKEY:[INNJUser user].token} andDelegate:self];
    }
}


-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    if(AddPredict == type && AddPredictSuccessStatus == [data[STATUSKEY] integerValue])
    {
        [self showText:@"预约成功"];
        [self removeDate];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else if(AddPredict == type)
    {
        [self showText:@"预约失败"];
    }
}

-(void) removeDate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HouseDate" inManagedObjectContext:[DataManage instance].managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"aid=%@",[INNJUser user].currentid];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[DataManage instance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil) {
        for(HouseDate* date in fetchedObjects)
        {
            [[DataManage instance].managedObjectContext deleteObject:date];
        }
        [[DataManage instance] saveContext];
    }
}
-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    [self showText:@"错误"];
}


-(void) contractAction:(id) sender
{
    [self.navigationController popViewControllerAnimated:NO];
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
