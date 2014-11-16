//
//  INNJHouseDetailViewController.m
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseDetailViewController.h"
#import "INNJInfoRequest.h"
#import "INNJHouseDetailTableViewCell.h"
#import "INNJContractViewController.h"
#import "INNJHouseListViewController.h"


@interface INNJHouseDetailViewController () <INNJInfoRequestDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSDictionary* data;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation INNJHouseDetailViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.hud.labelText = @"正在加载";
    [self showLoading];
    [[INNJInfoRequest request] makeRequest:GetHousebyAid andParams:@{HOUSEID:@(_aid)} andDelegate:self];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, self.view.height-self.topoffset-self.bottomoffset)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _tableview.separatorColor = [UIColor grayColor];
    [self.view addSubview:_tableview];
    
    self.navigationItem.title = @"详情";
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_data==nil)
        return 0;
    return 6;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 150;
        case 1:
            return 60;
        case 2:
            return 50;
        case 3:
        case 4:
            return 36;
        case 5:
            return 260;
    }
    
    return 0;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INNJHouseDetailTableViewCell* cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [INNJHouseDetailTableViewCell getView:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell bindData:@{@"image":_data[@"img"],@"intro":[NSString stringWithFormat:@"%@元/月    %@室%@厅    %@平米",_data[@"rent"],_data[@"shi"],_data[@"ting"],_data[@"area"]]}];
            
        }
            break;
        case 1:
        {
            cell = [INNJHouseDetailTableViewCell getView:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell bindData:_data];
      
        }
            break;
        case 2:
        {
            cell = [[INNJHouseDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIButton *submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 5, self.view.width-160, 40)];
            [submitbtn setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
            [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [submitbtn setTitle:@"我要看房" forState:UIControlStateNormal];
            [submitbtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:submitbtn];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 3:
        {
            cell = [INNJHouseDetailTableViewCell getView:2];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            [cell bindData:@{@"title":@"小区详情"}];
           
        }
            break;
        case 4:
        {
            cell = [INNJHouseDetailTableViewCell getView:2];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            [cell bindData:@{@"title":@"同小区房源"}];
            
        }
            break;
        case 5:
        {
            cell = [INNJHouseDetailTableViewCell getView:3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell bindData:@{@"dt":_data[@"dt"],@"address":_data[@"address"]}];
            
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==3 || indexPath.row == 4)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if(3 == indexPath.row)
        {
            [[INNJInfoRequest request] makeRequest:GetVillage andParams:@{HOUSEVILLAGE:_data[@"village"]} andDelegate:self];
        }else
        {
            INNJHouseListViewController* controller = [[INNJHouseListViewController alloc] initWithType:VillageHouseList];
           
            [self.navigationController pushViewController:controller animated:YES];
            controller.villagename=_data[@"village"];
        }
    }else
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

}
-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    
    
    NSLog(@"%@",data);
    
    if(GetHousebyAid == type)
    {
        _data = data[@"data"];
        [_tableview reloadData];
    }
}

-(void) submitAction:(id) sender
{
    INNJContractViewController *controller =  [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"contractcontroller"];
    [self.navigationController pushViewController:controller animated:YES];
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
