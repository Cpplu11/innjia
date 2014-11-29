//
//  INNJEntrustViewControler.m
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJEntrustViewController.h"
#import "INNJInfoRequest.h"
#import "INNJUser.h"
#import "INNJEntrustTableViewCell.h"
#import "INNJAddEntrustViewController.h"

#import "HouseEntrust.h"
#import "DataManage.h"
#import <CoreData/CoreData.h>
@interface INNJEntrustViewController ()<UITableViewDataSource,UITableViewDelegate,INNJInfoRequestDelegate>
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation INNJEntrustViewController
{
    NSDateFormatter *_datetimeformatter;
    INNJEntrustTableViewCell *_cellhead;
}
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
    // Do any additional setup after loading the view
    if(self.navigationController)
        self.navigationItem.title = @"我的委托";
    
    _datetimeformatter = [[NSDateFormatter alloc] init];
    [_datetimeformatter setDateFormat:@"yyyy-MM-dd"];
    [_tableview reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:LOGOUTNITIFICATION object:nil];
    
    _data = [[NSMutableArray alloc] init];
    
    _cellhead = [INNJEntrustTableViewCell getView];
    [_cellhead bindData:@{ADDRESSKEY:@"位置",DATEKEY:@"委托日期",CITYKEY:@"",ROOMKEY:@"房型"}];
    _cellhead.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    _cellhead.frame = CGRectMake(0, self.topoffset, self.view.width,44);
    [self.view addSubview:_cellhead];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset+44, self.view.width,self.view.height - self.topoffset-self.bottomoffset-44)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    self.loginView.frame = CGRectMake((self.view.width - self.loginView.width)/2, (self.view.height - self.loginView.height)/2, self.loginView.width, self.loginView.height);
    [self.view addSubview:self.loginView];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
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
    if(islogin)
    {
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
 
        self.navigationItem.leftBarButtonItem = addItem;
        
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
        
        self.navigationItem.rightBarButtonItem = editItem;
    
       
        [self.loginView removeFromSuperview];
        if(_tableview.superview == nil)
        {
            [self.view addSubview:_tableview];
            [self.view addSubview:_cellhead];
        }
        [self fetchData];
    }else
    {
        self.navigationItem.leftBarButtonItem = nil;
        [_tableview removeFromSuperview];
        [_cellhead removeFromSuperview];
        if(self.loginView.superview==nil)
        {
            [self.view addSubview:self.loginView];
        }
    }
}

-(void) fetchData
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HouseEntrust" inManagedObjectContext:[DataManage instance].managedObjectContext];
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

-(void) infoRequest
{
    
    
}

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    
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
        [cell.contentView addSubview:[self getEmptyView:_tableview.bounds withText:@"你的委托目前为空"]];
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
    
    
    INNJEntrustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLKEY];
    if(cell == nil)
    {
        cell = [INNJEntrustTableViewCell getView];
    }
    
    HouseEntrust *entrust = _data[indexPath.row/2];
    [cell bindData:@{DATEKEY:[_datetimeformatter stringFromDate:entrust.date],ADDRESSKEY:entrust.address,ROOMKEY:entrust.shi}];
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
    return 44;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [self isEmptyData]? 1:[_data count]*2;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self isEmptyData])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    INNJAddEntrustViewController *controller = [[INNJAddEntrustViewController alloc] init];
    NSInteger choose = indexPath.row/2;
    controller.entrustid = ((HouseEntrust*)_data[choose]).enid;
    controller.showflag = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
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
        
        HouseEntrust *entrust = _data[indexPath.row/2];
        [[DataManage instance].managedObjectContext deleteObject:entrust];
        [[DataManage instance] saveContext];
        
        [_data removeObjectAtIndex:indexPath.row/2];
        
        if([_data count]>0)
        {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nextIndexPath,nil] withRowAnimation:UITableViewRowAnimationRight];
        }else
        {
            [_tableview reloadData];
        }
    }
    
    [_tableview setEditing:NO animated:YES];

    
}
-(void) editAction:(id)sender
{
    if(!_tableview.editing)
        [_tableview setEditing:YES animated:YES];
    else
        [_tableview setEditing:NO animated:YES];
}


-(void) addAction:(id)sender
{
    INNJAddEntrustViewController *controller = [[INNJAddEntrustViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
