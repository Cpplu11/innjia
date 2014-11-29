//
//  INNJDateViewController.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJDateViewController.h"
#import "INNJInfoRequest.h"
#import "INNJHouseTableViewCell.h"
#import "INNJUser.h"
#import "HouseDate.h"
#import "DataManage.h"
#import "INNJHouseDetailViewController.h"
#import "INNJContractViewController.h"
#import <CoreData/CoreData.h>

@interface INNJDateViewController () <UITableViewDelegate,UITableViewDataSource,INNJInfoRequestDelegate>
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSArray *dated;
@end

@implementation INNJDateViewController

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
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:LOGOUTNITIFICATION object:nil];
    self.navigationItem.title = @"我的约看";
    
    
    //登录显示的状态
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width,self.view.height - self.topoffset-self.bottomoffset)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    _data = [[NSMutableArray alloc] init];
    //登出状态
    self.loginView.frame = CGRectMake((self.view.width - self.loginView.width)/2, (self.view.height - self.loginView.height)/2, self.loginView.width, self.loginView.height);
    [self.view addSubview:self.loginView];
    
   
}

-(void) viewWillAppear:(BOOL)animated
{
    [self initUI:[[INNJUser user] isLogin]];
}

-(void) fetchData
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HouseDate" inManagedObjectContext:[DataManage instance].managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    [fetchRequest setPredicate:nil];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                                   ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[DataManage instance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil) {
        _data = [[NSMutableArray alloc] initWithArray:fetchedObjects];
        [_tableview reloadData];
    }
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
    
    if(!islogin)
    {
        self.navigationItem.rightBarButtonItem = nil;
        if(self.loginView.superview == nil)
        {
            [self.view addSubview:self.loginView];
        }
        [_tableview removeFromSuperview];
    }else
    {
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
        self.navigationItem.rightBarButtonItem = editItem;
        
        if(_tableview.superview == nil)
        {
            [self.view addSubview:_tableview];
        }
        [self fetchData];
        [self.loginView removeFromSuperview];
    }
    
    
    
}

-(BOOL) isEmptyData
{
   return _data==nil || [_data count]==0;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self isEmptyData])
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self getEmptyView:_tableview.bounds withText:@"你的预约目前为空"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if(indexPath.row&1)
    {
        UITableViewCell *emptycell = [tableView dequeueReusableCellWithIdentifier:@"EMPTY"];
        if(emptycell==nil)
            emptycell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EMPTY"];
        emptycell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(20,0, self.view.width-40, 1)];
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [emptycell.contentView addSubview:view];
        return emptycell;
    }
    
    INNJHouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLKEY];
    
    if(cell == nil)
    {
        cell = [INNJHouseTableViewCell getView];
    }
    [cell bindHouseDate:[_data objectAtIndex:indexPath.row/2]];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isEmptyData])
    {
        return _tableview.height;
    }
    
    if(indexPath.row&1)
        return 1;
    return 110;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self isEmptyData]? 1:[_data count]*2;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isEmptyData])
    {
        return UITableViewCellEditingStyleNone;
    }
    
    if(indexPath.row&1)
        return UITableViewCellEditingStyleNone;
    return UITableViewCellEditingStyleDelete;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isEmptyData])
    {
        return ;
    }
    
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        HouseDate *date = _data[indexPath.row/2];
        [[DataManage instance].managedObjectContext deleteObject:date];
        [[DataManage instance] saveContext];
        
        [_data removeObjectAtIndex:indexPath.row/2];
        
        if([_data count]>0)
        {
            NSIndexPath *nextindexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nextindexPath,nil] withRowAnimation:UITableViewRowAnimationRight];
        }else
        {
            [_tableview reloadData];
        }
    }
    [_tableview setEditing:NO animated:YES];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isEmptyData])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HouseDate* date = _data[indexPath.row/2];
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    INNJContractViewController *controller = [board instantiateViewControllerWithIdentifier:@"contractcontroller"];
    [INNJUser user].currentid = [NSString stringWithString: date.aid];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void) editAction:(id)sender
{
    if(!_tableview.editing)
        [_tableview setEditing:YES animated:YES];
    else
        [_tableview setEditing:NO animated:YES];
}


-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    NSInteger status = [data[STATUSKEY] integerValue];
    if(GetPredictbyTel == type)
    {
        if(116 == status)
        {
            [self showText:@"没有预约信息"];
        }else if(115 == status)
        {
            [self showText:@"获取成功"];
            [_tableview reloadData];
        }else
        {
            [self showText:@"预约信息获取失败"];
        }
    }
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    
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
