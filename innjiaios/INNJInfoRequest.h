//
//  INNJInfoRequest.h
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define APIROOT @"http://api.udao.sh.cn/index.php/Api/"
#define API(ROOT,FUNC)   [NSString stringWithFormat:@"%@%@",ROOT,FUNC];

//LOGIN
#define APIKEY @"Innjia2014"
#define TELEPHONEKEY @"tel"
#define CODEKEY @"code"
#define VERIFYKEY @"verify"
#define TOKENKEY @"token"
//GetHouseByAid
#define HOUSEID @"id"
#define HOUSEAID @"aid"
#define HOUSEIMAGE @"img"
//GetHouseByDt
#define HOUSESTARTDT @"startdt"
#define HOUSEENDDT @"enddt"
//GetHouseByVillage,GetVillage
#define HOUSEVILLAGE @"village"

//Predicate
#define USERNAME @"realname"
#define USERSEX @"sex"
#define USERDATE @"date"

//Entrust
#define USERCITY @"city"
#define RENTCOST @"rent"
#define ROOMS @"shi"
#define CHECKTIME @"checkintime"
#define MEMO @"memo"

//search

#define SEARCHKEY @"search"
#define ID @"id"

#define STATUSKEY @"status"


typedef NS_ENUM(NSInteger, RequestType)
{
    StepMobile = 0,
    CheckMobile,
    GetHousebyAid,
    GetHousebyDt,
    GetHousebyVillage,
    GetVillage,
    AddPredict,
    GetPredictbyId,
    GetPredictbyTel,
    GetUnknown,
    AddEntrust,
    GetEntrustbyId,
    GetEntrustbyTel,
    GetHouseBySearch
};

typedef NS_ENUM(NSInteger, InfoStatus)
{
    CodeErrorStatus=99,
   
    //StepMobile
    StepSuccessStatus=100,
    //CheckMobile
    VerifySuccessStatus=101,
    VerifyErrorStatus=102,
    //GetHouseByAid
    GetHouseByAidSuccessStatus = 110,
    GetHouseByAidNotExistStatus = 111,
    //GetHouseByDt,GetHouseByVillage
    GetHouseByDtSuccessStatus = 103,
    
    //GetVillage
    GetVillageSuccessStatus = 120,
    GetVillageNotExistStatus = 121,
    //AddPredict
    AddPredictSuccessStatus = 111,
    AddPredictErrorStatus = 131,
    
    //GetPredictById
    GetPredictByIdSuccessStatus =140,
    GetPredictByIdNotExistSuccess = 141,
    
    //GetPredictByTel
    GetPredictByTelSuccessStatus = 116,
    
    //AddEntrust
    AddEntrussSuccessStatus = 115,
    AddEntrussErrorStatus = 116,
    
    //GetEntrustById
    GetEntrustByIdSuccessStatus = 123,
    GetEntrustByIdNotExistStatus = 124,
    
    //GetEntrustByTel
    GetEntrustByTelSuccessStatus = 170,
    GetEntrustByTelNotExistStatus = 171
    
};
@protocol INNJInfoRequestDelegate <NSObject>
-(void) infoDone:(NSDictionary*)data withType:(RequestType) type;
-(void) errorDone:(NSError*) error withType:(RequestType)type;
@end

@interface INNJInfoRequest : NSObject
+(INNJInfoRequest*) request;
-(void) makeRequest:(RequestType) type andParams:(NSDictionary*) params andDelegate:(id<INNJInfoRequestDelegate>) delegate;
@end
