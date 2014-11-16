//
//  INNJInfoRequest.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJInfoRequest.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
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
        _apis = @[@"Ainn/stepMobile",@"Ainn/checkMoblie",@"House/getHousebyAid",@"House/getHousebyDt",@"House/getHousebyVillage",@"House/getVillage",@"House/addPredict",@"House/getPredictbyId",@"House/getPredictbyTel",@"House/getPredictbyId",@"House/addEntrust",@"House/getEntrustbyId",@"House/getEntrustbyTel"];
    }
      
    return self;
}
-(void) makeRequest:(RequestType)type andParams:(NSDictionary*) cparams andDelegate:(id<INNJInfoRequestDelegate>)delegate
{
    NSString* url = API(APIROOT, _apis[type]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:cparams];
    switch (type) {
        case StepMobile:
        {
            
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@",[params objectForKey:TELEPHONEKEY],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
           
        }
            break;
        case CheckMobile:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@%@",params[TELEPHONEKEY],params[VERIFYKEY],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
            
        }
            break;
        case GetHousebyAid:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@",params[HOUSEID],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
        case GetHousebyDt:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@%@",params[HOUSESTARTDT],params[HOUSEENDDT],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
        case GetVillage:
        case GetHousebyVillage:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@",params[HOUSEVILLAGE],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
            
        }
            break;
        case AddPredict:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@%@%@%@",params[HOUSEID],params[USERNAME],params[USERSEX],params[USERDATE],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
            
        case AddEntrust:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",params[USERNAME],params[TELEPHONEKEY],params[USERSEX],params[USERCITY],params[HOUSEVILLAGE],params[RENTCOST],params[ROOMS],params[CHECKTIME],params[MEMO],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
            
        case GetEntrustbyId:
        case GetPredictbyId:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@",params[ID],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
        case GetEntrustbyTel:
        case GetPredictbyTel:
        {
            NSString *md5 = [self MD5:[NSString stringWithFormat:@"%@%@",params[TELEPHONEKEY],APIKEY]];
            [params setObject:md5 forKey:CODEKEY];
        }
            break;
        
        default:
            break;
    }
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [delegate infoDone:responseObject withType:type];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [delegate errorDone:error withType:type];
    }];
}

-(NSString*) MD5:(NSString*)str
{
    const char *cstr = [str UTF8String];
    
    unsigned char md5[16];
    CC_MD5(cstr,strlen(cstr),md5);
    NSMutableString *md5str= [[NSMutableString alloc] init];
    for(int i=0;i<16;i++)
    {
        [md5str appendString:[NSString stringWithFormat:@"%02x",md5[i]]];
    }
    return md5str;
    
}
@end
