//
//  INNJInfoRequest.h
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define APIROOT @"http://api.innjia.com/index.php/Api/"
#define API(ROOT,FUNC)   [NSString stringWithFormat:@"%@%@",ROOT,FUNC];

typedef NS_ENUM(NSInteger, RequestType)
{
    StepMobile = 0,
    CheckMobile,
    GetHousebyAid,
    GetHousebyDt,
    GetHousebyVillage,
    GetVollage,
    AddPredict,
    GetPredictbyId,
    GetPredictbyTel,
    GetUnknown,
    AddEntrust,
    GetEntrustbyId,
    GetEntrustbyTel
};

@protocol INNJInfoRequestDelegate <NSObject>
-(void) infoDone:(NSDictionary*)data withStatus:(NSInteger) status;
-(void) errorDone:(NSInteger) status;
@end

@interface INNJInfoRequest : NSObject
+(INNJInfoRequest*) request;
-(void) makeRequest:(RequestType) type andParams:(NSDictionary*) params andDelegate:(id<INNJInfoRequestDelegate>) delegate;
@end
