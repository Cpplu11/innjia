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
@interface INNJEntrustViewController ()<UITableViewDataSource,UITableViewDelegate,INNJInfoRequestDelegate>
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation INNJEntrustViewController

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
    self.navigationItem.title = @"我的委托";
    [self initUI:[[INNJUser user] isLogin]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:LOGINNOTIFICATION object:nil];
    
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
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editAction:)];
    
    self.navigationItem.leftBarButtonItem = addItem;
    self.navigationItem.rightBarButtonItem = editItem;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width,self.view.height - self.topoffset-self.bottomoffset)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
    _data = [NSMutableArray arrayWithArray: @[@{DATEKEY:@"DATE",ADDRESSKEY:@"adasdsa",ROOMKEY:@"dasd"},@{DATEKEY:@"DATE",ADDRESSKEY:@"adasdsa",ROOMKEY:@"dasd"},@{DATEKEY:@"DATE",ADDRESSKEY:@"adasdsa",ROOMKEY:@"dasd"}]];
  
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    INNJEntrustTableViewCell *cell = [INNJEntrustTableViewCell getView];
    [cell bindData:@{ADDRESSKEY:@"位置",DATEKEY:@"委托日期",ROOMKEY:@"房型"}];
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return  cell;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INNJEntrustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLKEY];
    if(cell == nil)
    {
        cell = [INNJEntrustTableViewCell getView];
        [cell bindData:_data[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
