//
//  INNJRentHouseViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJRentHouseViewController.h"
#import "INNJHouseListViewController.h"
#import "INNJPoint.h"
#import "INNJSearchViewController.h"


#define MINDISTANCE 0.002
#define SHANGHAILOCATION CLLocationCoordinate2DMake(31.24551,121.517581)
#define STRINGFROMCOOR(location) [NSString stringWithFormat:@"%f,%f",location.latitude,location.longitude]
#define LATDELTA 0.066095
#define LONGDELTA 0.047431

@interface INNJRentHouseViewController ()
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) UISearchBar *searchbar;
@end

@implementation INNJRentHouseViewController
{
    BMKMapView * _mapview;
    INNJHouseListViewController *_listcontroller;
    NSMutableDictionary * _mapinfo;
    NSMutableArray * _annotations;
    INNJHouseListViewController *_listcontroller2;
    BOOL _houseshow;
    BOOL _searchshow;
    NSMutableArray *_gestures;
    CLLocationCoordinate2D _oldcoordinate2d;
    NSInteger _oldzoomlevel;
    BOOL _isfirst;
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
    // Do any additional setup after loading the view.
     _isfirst = YES;
    
    [self initMap];
    [self initNavigationBar];
    _listcontroller = [[INNJHouseListViewController alloc] initWithType:MapHouseList];
    [self addChildViewController:_listcontroller];
    _listcontroller.view.frame = _mapview.frame;
    
    _listcontroller2 = [[INNJHouseListViewController alloc] initWithType:MapHousePart];
    _listcontroller2.view.frame = CGRectMake(0, self.view.height - self.bottomoffset, self.view.width, 200);
    _listcontroller2.navdelegate = self.navigationController;
    [self.view addSubview:_listcontroller2.view];
    
    CGFloat statusoffset = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, statusoffset, self.view.width,0)];
    _searchbar.delegate = self;
    _searchbar.barStyle = UIBarStyleDefault;
    [_searchbar setBackgroundImage:[UIImage imageWithColor:DEFAULTCOLOR]];
    [self.view addSubview:_searchbar];
    
    [(UIButton*) [self.editView viewWithTag:DONEBTNTAG] addTarget:self action:@selector(resignAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _mapinfo = [[NSMutableDictionary alloc] init];
    _annotations = [[NSMutableArray alloc] init];
    _gestures = [[NSMutableArray alloc] init];
    
    _oldcoordinate2d = {0,0};
    _oldzoomlevel = 0;
   
}

-(void) resignAction:(id) sender
{
    [_searchbar resignFirstResponder];
}

-(void) initMap
{
    UIView *wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, self.view.height-self.topoffset-self.bottomoffset)];
    [self.view addSubview:wrapper];
    _mapview = [[BMKMapView alloc] initWithFrame:wrapper.bounds];
    _mapview.delegate = self;
    _mapview.rotateEnabled = NO;
    _mapview.showMapScaleBar = YES;
    _mapview.showsUserLocation = YES;
    _mapview.zoomLevel = 15;
    
    [_mapview setCenterCoordinate:SHANGHAILOCATION];
    
    [wrapper addSubview:_mapview];
    wrapper.userInteractionEnabled = YES;
    _mapview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapAction:)];
    [_gestures addObject:tap];
    [_mapview addGestureRecognizer:tap];
}

-(void) initNavigationBar
{
    if(self.navigationController)
    {
        
        UIBarButtonItem *mapbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map_mark"] style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];
        
        UIBarButtonItem *listbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list_button"] style:UIBarButtonItemStylePlain target:self action:@selector(listAction:)];
        UIBarButtonItem *searchbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_button"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
        
        self.navigationItem.leftBarButtonItems=@[mapbtn,listbtn];
        self.navigationItem.rightBarButtonItem = searchbtn;
        self.navigationItem.title = @"盈家找房";
    }
}

-(void) mapAction:(id) sender
{
    [self hideHouse];
    [self hideSearch];
    [UIView transitionFromView:_listcontroller.view toView:_mapview duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
}

-(void) listAction:(id) sender
{
    [self hideHouse];
    [self hideSearch];
    [UIView transitionFromView:_mapview toView:_listcontroller.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    [_listcontroller bindData:self.data];
    
}

-(void) searchAction:(id) sender
{
    [self hideHouse];
    INNJSearchViewController *controller = [[INNJSearchViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"---------START----------");
    NSLog(@"%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
    NSLog(@"%d",mapView.zoomLevel);
    NSLog(@"---------END----------");

    
    if(_oldzoomlevel ==0 || [self moveDistance:_oldcoordinate2d andNew:mapView.centerCoordinate]>MINDISTANCE || _oldzoomlevel != mapView.zoomLevel)
    {
    
            [self showLoading];
        
            if(!_isfirst)
            {
                [self infoRequest:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude+_mapview.region.span.latitudeDelta/2.0 ,_mapview.centerCoordinate.longitude-_mapview.region.span.longitudeDelta/2.0) andEnd:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude-_mapview.region.span.latitudeDelta/2.0,_mapview.centerCoordinate.longitude+_mapview.region.span.longitudeDelta/2.0)];
            }else
            {
                [self infoRequest:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude+LATDELTA/2.0 ,_mapview.centerCoordinate.longitude-LONGDELTA/2.0) andEnd:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude-LATDELTA/2.0,_mapview.centerCoordinate.longitude+LONGDELTA/2.0)];
            }
        _isfirst = NO;
    }
    _oldcoordinate2d = mapView.centerCoordinate;
    _oldzoomlevel = mapView.zoomLevel;
}

-(CGFloat) moveDistance:(CLLocationCoordinate2D) oldcoordinate2d andNew:(CLLocationCoordinate2D) newcoordinate2d
{
    double oldoffsetlat = oldcoordinate2d.latitude-newcoordinate2d.latitude;
    double oldoffsetlong = oldcoordinate2d.longitude - newcoordinate2d.longitude;
    return sqrt(oldoffsetlat*oldoffsetlat+oldoffsetlong*oldoffsetlong);
}

-(void) infoRequest:(CLLocationCoordinate2D) startdt andEnd:(CLLocationCoordinate2D) enddt
{
    NSDictionary *params = @{HOUSESTARTDT:STRINGFROMCOOR(startdt),HOUSEENDDT:STRINGFROMCOOR(enddt)};
    NSLog(@"%@",params);
    [[INNJInfoRequest request] makeRequest:GetHousebyDt andParams:params andDelegate:self];
    
}

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    //NSLog(@"%@",data);
    self.data = data[@"data"];
    [_listcontroller bindData:self.data];
    [self mapInfo:_data];
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    
}

-(void) mapInfo:(NSArray*)data
{
    [_mapview removeAnnotations:_annotations];
    [_mapinfo removeAllObjects];
    for(NSDictionary * item in data)
    {
        NSString* dtkey = [item objectForKey:@"dt"];
        if(_mapinfo[dtkey] == nil)
        {
            _mapinfo[dtkey] = [[NSMutableArray alloc] init];
        }
        
        [_mapinfo[dtkey] addObject:item];
    }
    
    [_annotations removeAllObjects];
    for(NSString *dtkey in _mapinfo)
    {
        NSArray *position = [dtkey componentsSeparatedByString:@","];
       
        if(position!=nil && [position count]==2)
        {
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [position[0] floatValue];
            coordinate.longitude = [position[1] floatValue];
            INNJPoint *point = [[INNJPoint alloc] init];
            point.key = dtkey;
            [point setCoordinate:coordinate];
            [_annotations addObject:point];
        }
    }
    [_mapview addAnnotations:_annotations];
}


-(void) mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [self hideHouse];
}


-(BMKAnnotationView*) mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if( [annotation isKindOfClass:[INNJPoint class]])
    {
        
        INNJPointView* pointview = ( INNJPointView*)[mapView dequeueReusableAnnotationViewWithIdentifier:REUSEID];
        
        
        if(pointview == nil)
            pointview = [[INNJPointView alloc] initWithAnnotation:annotation reuseIdentifier:REUSEID];
        pointview.annotation = annotation;
        INNJPoint *p = annotation;
        pointview.label.text = [NSString stringWithFormat:@"%d",[[_mapinfo objectForKey:p.key] count]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_gestures addObject:tap];
        [pointview addGestureRecognizer:tap];
        return  pointview;
    }
    
    return nil;
}

-(void) tapAction:(UITapGestureRecognizer*)gesture
{
    INNJPoint * point =((INNJPointView*) gesture.view).annotation;
    [_listcontroller2 bindData:_mapinfo[point.key]];
    [self showHouse];
}
-(void) mapTapAction:(UITapGestureRecognizer*)gesture
{
    [self hideSearch];
    [self hideHouse];
}


-(void) showHouse
{
    if(!_houseshow)
    {
        _houseshow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _listcontroller2.view.top -=200;
        }];
    }
}
-(void) hideHouse
{
    if(_houseshow)
    {
         _houseshow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _listcontroller2.view.top +=200;
        }];
    }
}

-(void) showSearch
{
    
    if(!_searchshow)
    {
        _searchshow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _searchbar.frame = CGRectMake(0, self.topoffset, self.view.width, self.topoffset-20);
        }];
    }
}

-(void) hideSearch
{
    if(_searchshow)
    {
        _searchshow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _searchbar.frame = CGRectMake(0, self.topoffset- _searchbar.height, self.view.width, 0);
        }];
    }
}

- (void) dealloc
{
    _mapview.delegate  = nil;
    [_gestures removeAllObjects];
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
