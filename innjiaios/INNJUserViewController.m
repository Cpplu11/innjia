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
#import "Favourites.h"
#import "DataManage.h"
#import <CoreData/CoreData.h>
#import "INNJHouseListViewController.h"
@interface INNJUserViewController () <UITableViewDataSource,UITableViewDelegate,INNJLoginProtocol>
@property (strong, nonatomic) UITableView *tableview;
@end

@implementation INNJUserViewController
{
    NSArray * _titles;
    NSArray * _subtitles;
    NSArray * _images;
    BOOL _islogin;
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:LOGOUTNITIFICATION object:nil];
    self.navigationItem.title = @"我的";
   
    [self.view addSubview:self.loginView];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginView.frame), self.view.width, self.view.height)];
 
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    [self.view addSubview:_tableview];
    
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
    _islogin = islogin;
    if(islogin)
    {
        _titles = @[@"当前用户",@"客服电话",@"我的收藏",@"检查更新",@"意见反馈",@"打赏点个赞",@"关于盈家",@"退出登录"];
        _subtitles = @[[INNJUser user].telephone,@"800-810-8666",@"",@"",@"",@"",@"",@""];
        _images = @[@"user-service-phone",@"user-service-phone",@"user-my-collection",@"user-check-update",@"user-feedback",@"user-rate",@"user-about",@"user-logout"];
        
       
        
      
        _tableview.frame = CGRectMake(0, self.topoffset, self.view.width, self.view.height-self.topoffset-self.bottomoffset);
        [self.loginView removeFromSuperview];
       
        
        _tableview.bounces = YES;

    }else
    {
        _titles = @[@"客服电话",@"检查更新",@"意见反馈",@"打赏点个赞",@"关于盈家"];
        _subtitles = @[@"800-810-8666",@"",@"",@"",@""];
        _images = @[@"user-service-phone",@"user-check-update",@"user-feedback",@"user-rate",@"user-about"];
        
        if(self.loginView.superview ==nil)
        {
            [self.view addSubview:self.loginView];
        }
        
        __weak INNJUserViewController *wself = self;
        [UIView animateWithDuration:1 animations:^{
            wself.loginView.top = self.topoffset;
            _tableview.frame = CGRectMake(0, CGRectGetMaxY(self.loginView.frame), self.view.width, self.view.height-CGRectGetMaxY(self.loginView.frame)-self.bottomoffset);
        }];
        
        _tableview.bounces = NO;
        
       
    }
    
    [_tableview reloadData];
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row&1)
        return 1;
    return 44;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row&1)
    {
        UITableViewCell *emptycell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EMPTY"];
        emptycell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(20,0, self.view.width-40, 1)];
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [emptycell.contentView addSubview:view];
        return emptycell;
    }
    
    
    INNJMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if(!cell)
    {
        cell = [INNJMineTableViewCell getView];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    [cell addData:[_images objectAtIndex:indexPath.row/2] andTitle:[_titles objectAtIndex:indexPath.row/2]];
    cell.subtitle.text = _subtitles[indexPath.row/2];
    
    return cell;
    
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles count]*2;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger choose = indexPath.row/2;
    if(_islogin)
    {
        switch (choose) {
            case 1:
            {
                [self callServiceTel];
            }
                break;
            case 2:
            {
                [self myFavourites];
            }
                break;
            case 3:
            {
                [self checkUpdate];
            }
                break;
            case 4:
            {
                [self feedback];
            }
                break;
            case 5:
            {
                [self rate];
            }
                break;
            case 6:
            {
                [self aboutInnjia];
            }
                break;
            case 7:
            {
                [[INNJUser user] logout];
            }
            default:
                break;
            }
    }else
    {
        switch (choose) {
            case 0:
            {
                [self callServiceTel];
            }
                break;
            case 1:
            {
                [self checkUpdate];
            }
                break;
            case 2:
            {
                [self feedback];
            }
                break;
            case 3:
            {
                [self rate];
            }
                break;
            case 4:
            {
                [self aboutInnjia];
            }
                break;
            default:
                break;
        }
    }
}

-(void) callServiceTel
{
    
}
-(void) myFavourites
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:[DataManage instance].managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [[DataManage instance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    INNJHouseListViewController *controller = [[INNJHouseListViewController alloc] init];
    controller.controllertype = FavouriteHouseList;
    if(fetchedObjects!=nil)
        [controller bindData:fetchedObjects];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void) checkUpdate
{
    
}
-(void) feedback
{
    
}

-(void) rate
{
    
}

-(void) aboutInnjia
{
    
}


@end
