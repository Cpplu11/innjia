//
//  INNJUserViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJUserViewController.h"
#import "INNJMineTableViewCell.h"
#import "INNJUser.h"
@interface INNJUserViewController () <UITableViewDataSource,UITableViewDelegate,INNJLoginProtocol>
@property (strong, nonatomic) UITableView *tableview;
@end

@implementation INNJUserViewController
{
    NSArray * _titles;
    NSArray * _images;
    BOOL _islogin;
}
-(void) viewDidLoad
{
   
    [self initUI:[[INNJUser user] isLogin]];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    self.navigationItem.title = @"我的";
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
    NSLog(@"%d",islogin);
    _islogin = islogin;
    if(islogin)
    {
        _titles = @[@"客服电话",@"我的收藏",@"检查更新",@"意见反馈",@"打赏点个赞",@"关于盈家",@"退出登录"];
        _images = @[@"user-service-phone",@"user-my-collection",@"user-check-update",@"user-feedback",@"user-rate",@"user-about",@"user-logout"];

    }else
    {
        _titles = @[@"客服电话",@"检查更新",@"意见反馈",@"打赏点个赞",@"关于盈家"];
        _images = @[@"user-service-phone",@"user-check-update",@"user-feedback",@"user-rate",@"user-about"];
       
    }
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, MIN(self.view.height-64-32,100+44*[_titles count]))];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0);
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INNJMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if(!cell)
    {
        cell = [INNJMineTableViewCell getView];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    [cell addData:[_images objectAtIndex:indexPath.row] andTitle:[_titles objectAtIndex:indexPath.row]];
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self loginView].height;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self loginView];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
