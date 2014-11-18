//
//  INNJHouseListViewController.m
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseListViewController.h"
#import "INNJHouseTableViewCell.h"
#import "INNJHouseDetailViewController.h"
#import "INNJInfoRequest.h"
#import "BMKMapView.h"
#import "BMKPointAnnotation.h"
@interface INNJHouseListViewController ()<UITableViewDataSource,UITableViewDelegate,INNJInfoRequestDelegate>

@end

@implementation INNJHouseListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithType:(INNJControllerType) type
{
    if(self = [super init])
    {
        self.controllertype = type;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, self.view.height-self.topoffset-self.bottomoffset)];
    _tableview.dataSource = self;
    _tableview.delegate  = self;
    _tableview.bounces = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    [_tableview setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, self.view.width-20)];
    [self.view addSubview:_tableview];
    
    if(VillageHouseList == _controllertype && _villagename !=nil)
    {
        [self showLoading];
        [[INNJInfoRequest request] makeRequest:GetHousebyVillage andParams:@{HOUSEVILLAGE:_villagename} andDelegate:self];
        if(self.navigationItem!=nil)
        {
            self.navigationItem.title=@"同小区房源";
        }
        _tableview.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    }
    
}

-(void) bindData:(NSArray*) data
{
    self.data = data;
    if(_tableview!=nil)
        [_tableview reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_controllertype == MapHousePart)
    {
        return 8;
    }else if(_controllertype == MapHouseList)
    {
        return 0;
    }else if(_controllertype == VillageHouseList)
    {
        return 100;
    }
    
    return 0;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(_controllertype == MapHousePart)
    {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 8)];
        view.backgroundColor = DEFAULTCOLOR;
        return view;
    }else if(_controllertype == VillageHouseList)
    {
        BMKMapView* map = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        map.zoomEnabled = NO;
        map.scrollEnabled = NO;
        map.zoomLevel = 16;
        
        if(_data!=nil && [_data count]>0)
        {
            NSString* dtstr = [[_data firstObject] objectForKey:@"dt"];
            if(dtstr!=nil)
            {
                NSArray * dt = [dtstr componentsSeparatedByString:@","];
                CLLocationCoordinate2D coordinate2d;
                coordinate2d.latitude = [dt[0] doubleValue];
                coordinate2d.longitude = [dt[1] doubleValue];
                BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
                point.coordinate = coordinate2d;
                [map setCenterCoordinate:coordinate2d];
                [map addAnnotation:point];
            }
        }
        
        return map;
    }
    
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    INNJHouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLKEY];
    if(cell==nil)
    {
        cell = [INNJHouseTableViewCell getView];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell bindData:_data[indexPath.row]];
    NSLog(@"%@",_data[indexPath.row]);
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    INNJHouseDetailViewController *controller = [[INNJHouseDetailViewController alloc] init];
    controller.aid = [[[_data objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue];
    if(self.navigationController!=nil)
    {
        [self.navigationController pushViewController:controller animated:YES];
    }else if( [_navdelegate isKindOfClass:[UINavigationController class]])
    {
        [_navdelegate pushViewController:controller animated:YES];
    }
}


-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    if(GetHousebyVillage == type)
    {
        NSLog(@"%@",data);
        _data = data[@"data"];
        [_tableview reloadData];
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
