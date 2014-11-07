//
//  INNJInfoRequest.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJInfoRequest.h"
#import <AFNetworking.h>
@interface INNJInfoRequest ()

@property (nonatomic,strong) NSArray* apis;

@end


@implementation INNJInfoRequest

+(INNJInfoRequest*) request
{
    static dispatch_once_t onceToken;
    static INNJInfoRequest *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[INNJInfoRequest alloc] init];
    });
    return instance;
}

-(id) init
{
    if(self = [super init])
    {
        _apis = @[@"Ainn/stepMoblie",@"Ainn/checkMoblie",@"House/getHousebyAid",@"House/getHousebyDt",@"House/getHousebyVillage",@"House/getVillage",@"House/addPredict",@"House/getPredictbyId",@"House/getPredictbyTel",@"House/getPredictbyId",@"House/addEntrust",@"House/getEntrustbyId",@"House/getEntrustbyTel"];
    }
      
    return self;
}
-(void) makeRequest:(RequestType)type andParams:(NSDictionary*) params andDelegate:(id<INNJInfoRequestDelegate>)delegate
{
    NSString* url = API(APIROOT, _apis[type]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
