//
//  INNJUserViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJUserViewController.h"
#import "INNJMineTableViewCell.h"
@interface INNJUserViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation INNJUserViewController
{
    NSArray * _titles;
    NSArray * _images;
}
-(void) viewDidLoad
{
    
    _titles = @[@"客服电话",@"我的收藏",@"检查更新",@"意见反馈",@"打赏点个赞",@"关于盈家",@"退出登录"];
    _images = @[@"user-service-phone",@"user-my-collection",@"user-check-update",@"user-feedback",@"user-rate",@"user-about",@"user-logout"];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0);
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
