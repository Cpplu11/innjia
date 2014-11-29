//
//  INNJSearchViewController.m
//  innjiaios
//
//  Created by wl on 14-11-23.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJSearchViewController.h"
#import "INNJHouseListViewController.h"
#define NUMPP 20
@interface INNJSearchViewController () <UITextFieldDelegate>
@property (nonatomic,strong) UITextField * searchtext;
@end

@implementation INNJSearchViewController

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
    
    if(self.navigationController!=nil)
    {
        self.navigationItem.title = @"搜索";
    }
    
    //
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.topoffset+10, self.view.width-40, 20)];
    label.textColor = [UIColor grayColor];
    label.text = @"房源名称/地址/小区名称";
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
    _searchtext = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+6, self.view.width-40, 36)];
    _searchtext.background = SCBGIMAGEOFF;
    _searchtext.font = [UIFont systemFontOfSize:16];
    PADDINGDEFAULT(_searchtext);
    [self.view addSubview:_searchtext];
    
    _searchtext.delegate = self;
    [(UIButton*)[self.editView viewWithTag:DONEBTNTAG] addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) searchAction:(id) sender
{
    [_searchtext resignFirstResponder];
    [self infoRequest];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_searchtext resignFirstResponder];
    [self infoRequest];
    return YES;
}

-(void) infoRequest
{
    if(_searchtext.text!=nil && _searchtext.text.length>0)
    {
        INNJHouseListViewController *controller = [[INNJHouseListViewController alloc] initWithType:SearchHouseList];
        controller.searchtext = _searchtext.text;
        [self.navigationController pushViewController:controller animated:YES];
    }else
    {
        [self showText:@"搜索关键词不许为空"];
    }
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
