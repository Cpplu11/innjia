//
//  INNJUser.m
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJUser.h"

@implementation INNJUser

+(INNJUser*) user
{
    static dispatch_once_t onceToken;
    static INNJUser* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[INNJUser alloc]init];
    });
    
    return instance;
}

-(id) init
{
    if(self = [super init])
    {
        _telephone = [[NSUserDefaults standardUserDefaults] objectForKey:INNJUSERTELEPHONEKEY];
        _token = [[NSUserDefaults standardUserDefaults] objectForKey:INNJUSERTOKENKEY];
    }
    
    return self;
}


-(BOOL) isLogin
{
    return _telephone !=nil;
}

-(void) logout
{
    _telephone = nil;
    _token = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INNJUSERTELEPHONEKEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INNJUSERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUTNITIFICATION object:nil];
}
-(void) login:(NSString*)telephone andToken:(NSString *)token
{
    _telephone = telephone;
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:_telephone forKey:INNJUSERTELEPHONEKEY];
    [[NSUserDefaults standardUserDefaults] setObject:_token forKey:INNJUSERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINNOTIFICATION object:nil];
}
@end
