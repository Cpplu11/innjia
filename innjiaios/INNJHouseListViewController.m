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
#import "Favourites.h"
#define NUMPPAGE 10

@interface INNJHouseListViewController ()<UITableViewDataSource,UITableViewDelegate,INNJInfoRequestDelegate>

@end

@implementation INNJHouseListViewController
{
    
    //SearchHouseList
    NSInteger _currentpage;
    NSDateFormatter *_datetimeformatter;
    
}
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
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.bottomoffset)];
    _tableview.dataSource = self;
    _tableview.delegate  = self;
    _tableview.bounces = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(VillageHouseList == _controllertype && _villagename !=nil)
    {
        [self showLoading];
        [[INNJInfoRequest request] makeRequest:GetHousebyVillage andParams:@{HOUSEVILLAGE:_villagename} andDelegate:self];
        if(self.navigationItem!=nil)
        {
            self.navigationItem.title=@"同小区房源";
        }
       
    }else if(SearchHouseList == _controllertype && _searchtext !=nil)
    {
        _currentpage = 1;
        self.navigationItem.title = _searchtext;
        [self infoRequst:_currentpage];
        _tableview.bounces = YES;
        
    }else if(FavouriteHouseList == _controllertype)
    {
        _tableview.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        self.navigationItem.title = @"我的收藏";
        _tableview.bounces = YES;
        _datetimeformatter = [[NSDateFormatter alloc] init];
        [_datetimeformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [_tableview reloadData];
    }
    
    [self.view addSubview:_tableview];
    
    
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"T:%@",NSStringFromCGRect(_tableview.frame));
    NSLog(@"V:%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"N:%@",NSStringFromCGRect(self.navigationController.view.frame));
}
-(void) bindData:(NSArray*) data
{
    self.data = [[NSMutableArray alloc] initWithArray: data];
    if(_tableview!=nil)
        [_tableview reloadData];
}
-(void) addData:(NSArray*) data
{
    if(_data==nil)
    {
        _data = [[NSMutableArray alloc] init];
    }
    [self.data addObjectsFromArray:data];
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
    if(indexPath.row&1)
        return 1;
    return 110;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    if(cell==nil)
    {
        cell = [INNJHouseTableViewCell getView];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(_controllertype == SearchHouseList)
    {
        NSDictionary *item = _data[indexPath.row/2];
        [cell bindOrignalData:@{NAMEKEY:item[@"address"],INTROKEY:item[@"subject"],ROOMKEY:[NSString stringWithFormat:@"%@平米 %@ %@",item[@"area"],item[@"floor"],item[@"countname"]],PRICEKEY:[NSString stringWithFormat:@"%@元",item[@"rent"]],IMAGEKEY:item[@"thumb"]}];
    }else if(_controllertype == FavouriteHouseList)
    {
        Favourites *fav = _data[indexPath.row/2];
        [cell bindOrignalData:@{NAMEKEY:fav.village,INTROKEY:fav.subject,IMAGEKEY:fav.image,PRICEKEY:[NSString stringWithFormat:@"%@元",fav.price],ROOMKEY:[NSString stringWithFormat:@"收藏时间:%@",[_datetimeformatter stringFromDate:fav.date]]}];
    }else
    {
        NSDictionary *item = _data[indexPath.row/2];
        [cell bindData:item];
    }
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data ==nil? 0:[_data count]*2;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    INNJHouseDetailViewController *controller = [[INNJHouseDetailViewController alloc] init];
    NSInteger choose =indexPath.row/2;
    if(_controllertype==SearchHouseList)
        controller.aid = [[[_data objectAtIndex:choose] objectForKey:@"aid"] integerValue];
    else if(_controllertype == FavouriteHouseList)
    {
        controller.aid = [[(Favourites*)[_data objectAtIndex:choose] aid] integerValue];
    }else
        controller.aid = [[[_data objectAtIndex:choose] objectForKey:@"id"] integerValue];
    
    if(self.navigationController!=nil)
    {
        [self.navigationController pushViewController:controller animated:YES];
    }else if( [_navdelegate isKindOfClass:[UINavigationController class]])
    {
        [_navdelegate pushViewController:controller animated:YES];
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f,%f,%f,%f",scrollView.contentOffset.y,scrollView.top,scrollView.height,scrollView.contentSize.height);
    if(_controllertype == SearchHouseList)
    {
        if(scrollView.contentOffset.y+scrollView.height>=scrollView.contentSize.height)
        {
            _currentpage +=1;
            [self infoRequst:_currentpage];
        }
    }
    
}

-(void) infoRequst:(NSInteger) page
{
    [self showLoading];
    [[INNJInfoRequest request] makeRequest:GetHouseBySearch andParams:@{SEARCHKEY:_searchtext,@"p":@(_currentpage),@"listrows":@(NUMPPAGE)} andDelegate:self];

}
-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    if(GetHousebyVillage == type || GetHouseBySearch == type)
    {
        //NSLog(@"%@",data);
        [self addData:data[@"data"]];
       
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
