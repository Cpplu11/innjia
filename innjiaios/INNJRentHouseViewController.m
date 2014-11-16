//
//  INNJRentHouseViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJRentHouseViewController.h"
#import "BMapKit.h"
#import "INNJInfoRequest.h"
#import "INNJHouseListViewController.h"
#import "INNJPoint.h"


#define SHANGHAILOCATION CLLocationCoordinate2DMake(31.24551,121.517581)
#define STRINGFROMCOOR(location) [NSString stringWithFormat:@"%f,%f",location.latitude,location.longitude]


@interface INNJRentHouseViewController () <BMKMapViewDelegate,INNJInfoRequestDelegate,UISearchBarDelegate>
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
    CLLocationCoordinate2D startdt = CLLocationCoordinate2DMake(31.214369, 120.566817);
    CLLocationCoordinate2D enddt = CLLocationCoordinate2DMake(30.214369, 122.566817);
    
    NSLog(@"!%f,%f",(startdt.latitude+enddt.latitude)/2, (startdt.longitude+enddt.longitude)/2);
    [_mapview setCenterCoordinate:SHANGHAILOCATION];
    _mapview.zoomLevel = 14;
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
//    if(_searchshow)
//    {
//        [self hideSearch];
//    }else
//    {
//        [self showSearch];
//    }
    
    
    [self infoRequest:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude+_mapview.region.span.latitudeDelta/2 ,_mapview.centerCoordinate.longitude-_mapview.region.span.longitudeDelta/2) andEnd:CLLocationCoordinate2DMake(_mapview.centerCoordinate.latitude-_mapview.region.span.latitudeDelta/2,_mapview.centerCoordinate.longitude+_mapview.region.span.longitudeDelta/2)];
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
    NSLog(@"%f,%f",mapView.region.center.latitude,mapView.region.center.longitude);
    NSLog(@"%f",mapView.zoomLevel);
    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
    NSLog(@"%f,%f,%f,%f",mapView.visibleMapRect.origin.x,mapView.visibleMapRect.origin.y,mapView.visibleMapRect.size.width,mapView.visibleMapRect.size.height);
    NSLog(@"---------END----------");
    
   //[self infoRequest:CLLocationCoordinate2DMake(31.214369,120.566817) andEnd:CLLocationCoordinate2DMake(30.814369,121.966817)];
}

-(void) infoRequest:(CLLocationCoordinate2D) startdt andEnd:(CLLocationCoordinate2D) enddt
{
    NSDictionary *params = @{HOUSESTARTDT:STRINGFROMCOOR(startdt),HOUSEENDDT:STRINGFROMCOOR(enddt)};
    NSLog(@"%@",params);
    [[INNJInfoRequest request] makeRequest:GetHousebyDt andParams:params andDelegate:self];
    
}

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    NSLog(@"%@",data);
    self.data = data[@"data"];
    [self mapInfo:_data];
}

-(void) errorDone:(NSError *)error withType:(RequestType)type
{
    
}

-(void) mapInfo:(NSArray*)data
{
    [_mapview removeOverlays:_annotations];
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
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [position[0] floatValue];
        coordinate.longitude = [position[1] floatValue];
        INNJPoint *point = [[INNJPoint alloc] init];
        point.key = dtkey;
        [point setCoordinate:coordinate];
        [_annotations addObject:point];
    }
    [_mapview addAnnotations:_annotations];
}


-(void) mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [self hideHouse];
}

-(void) showHouse
{
    if(!_houseshow)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _listcontroller2.view.top -=200;
        } completion:^(BOOL finished) {
            if(finished)
                _houseshow = YES;
        }];
    }
}
-(void) hideHouse
{
    if(_houseshow)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _listcontroller2.view.top +=200;
        } completion:^(BOOL finished) {
            if(finished)
                _houseshow = NO;
        }];
    }
}

-(void) showSearch
{
   
    if(!_searchshow)
    {
        [UIView animateWithDuration:0.5 animations:^{
        _searchbar.frame = CGRectMake(0, self.topoffset, self.view.width, self.topoffset-20);
        } completion:^(BOOL finished) {
            if(finished)
            {
                _searchshow = YES;
            }
        }];
    }
}

-(void) hideSearch
{
    if(_searchshow)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _searchbar.frame = CGRectMake(0, self.topoffset- _searchbar.height, self.view.width, 0);
        } completion:^(BOOL finished) {
            if(finished)
            {
                _searchshow = NO;
            }
        }];
    }
}
-(void) mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
     NSLog(@"%@",((INNJPoint*)view.annotation).key);
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


- (void) dealloc
{
    _mapview.delegate  = nil;
    [_gestures removeAllObjects];
}
-(void) viewWillDisappear:(BOOL)animated
{
    _mapview.delegate = nil;
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
