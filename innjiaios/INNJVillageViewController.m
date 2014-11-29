//
//  INNJVillageViewController.m
//  innjiaios
//
//  Created by wl on 14-11-27.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJVillageViewController.h"
#import "BMKMapView.h"
#import "INNJInfoRequest.h"
#import "BMKPointAnnotation.h"
#define FONTNAME [UIFont systemFontOfSize:14]
#define EMPTYTEXT(str) (str==nil|| str ==[NSNull null])? @"空":str
@interface INNJVillageViewController () <INNJInfoRequestDelegate>
@property (nonatomic,strong) NSDictionary *data;
@end

@implementation INNJVillageViewController

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
    
    [self infoRequest];
    if(self.navigationController)
    {
        self.navigationItem.title = @"小区详情";
    }
}
-(void) infoRequest
{
    [self showLoading];
    [[INNJInfoRequest request] makeRequest:GetVillage andParams:@{HOUSEVILLAGE:_village} andDelegate:self];
}

-(void) infoDone:(NSDictionary *)data withType:(RequestType)type
{
    [self dismissLoading];
    if(GetVillage == type && data!=nil)
    {
        _data = data;
        BMKMapView* map = [[BMKMapView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, 200)];
        map.zoomEnabled = NO;
        map.scrollEnabled = NO;
        map.zoomLevel = 16;
    
        if(_data!=nil)
        {
            NSString* dtstr = [_data objectForKey:@"dt"];
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
    
        [self.view addSubview:map];
    
    //各属性
        NSString *subject = [NSString stringWithFormat:@"小区名称: %@",EMPTYTEXT(_data[@"subject"]) ];
        NSMutableParagraphStyle *paragrapstyle = [[NSMutableParagraphStyle alloc] init];
        CGSize subjectsize = [subject sizeWithAttributes:@{NSFontAttributeName:FONTNAME,NSParagraphStyleAttributeName:paragrapstyle}];
        UILabel *subjectlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(map.frame)+10, self.view.width-40, (1+subjectsize.width/(self.view.width-40))*subjectsize.height)];
        subjectlabel.text = subject;
        subjectlabel.lineBreakMode = NSLineBreakByWordWrapping;
        subjectlabel.numberOfLines = 0;
        subjectlabel.font = FONTNAME;
       // subjectlabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:subjectlabel];
        
    
        UILabel *citylabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(subjectlabel.frame)+8, self.view.width-40, 20)];
        citylabel.text = [NSString stringWithFormat:@"城市: %@ %@ %@",EMPTYTEXT(_data[@"city"]),EMPTYTEXT(_data[@"district"]),EMPTYTEXT(_data[@"business"]) ];
        citylabel.adjustsFontSizeToFitWidth = YES;
        citylabel.font = FONTNAME;
        [self.view addSubview:citylabel];
    
        UILabel *addresslabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(citylabel.frame)+8, self.view.width-40, 20)];
        addresslabel.text = [NSString stringWithFormat:@"地址: %@",EMPTYTEXT(_data[@"address"]) ];
        addresslabel.adjustsFontSizeToFitWidth = YES;
        addresslabel.font = FONTNAME;
        [self.view addSubview:addresslabel];
    
        
        NSString *describe =[NSString stringWithFormat:@"介绍: %@",EMPTYTEXT(_data[@"describe"])];
        CGSize describesize = [describe sizeWithAttributes:@{NSFontAttributeName:FONTNAME}];
        
        UILabel *describelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(addresslabel.frame)+8, self.view.width-40, (1+describesize.width/(self.view.width-40))*describesize.height)];
        describelabel.numberOfLines = 0;
        describelabel.adjustsFontSizeToFitWidth = YES;
        describelabel.font = FONTNAME;
        describelabel.text = describe;
        [self.view addSubview:describelabel];
    
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
