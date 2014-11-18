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
@interface INNJDateViewController () <UITableViewDelegate,UITableViewDataSource,INNJInfoRequestDelegate>
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,strong) NSMutableArray *data;
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
    
    [self initUI:[[INNJUser user] isLogin]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    self.navigationItem.title = @"我的约看";
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

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width,self.view.height - self.topoffset-self.bottomoffset)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self.view addSubview:_tableview];
    _data = [NSMutableArray arrayWithArray: @[@{NAMEKEY:@"name",PRICEKEY:@"123",INTROKEY:@"12",ROOMKEY:@"12",TINGKEY:@"12",IMAGEKEY:@"123"},@{NAMEKEY:@"name",PRICEKEY:@"123",INTROKEY:@"12",ROOMKEY:@"12",TINGKEY:@"12",IMAGEKEY:@"123"}]];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = editItem;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INNJHouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLKEY];
    if(cell == nil)
    {
        cell = [INNJHouseTableViewCell getView];
        [cell bindData:_data[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data==nil? 0:[_data count];
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}
-(void) editAction:(id)sender
{
    if(!_tableview.editing)
        [_tableview setEditing:YES animated:YES];
    else
        [_tableview setEditing:NO animated:YES];
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
