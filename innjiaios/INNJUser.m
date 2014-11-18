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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INNJUSERTELEPHONEKEY];
}
-(void) login:(NSString*)telephone
{
    _telephone = telephone;
    [[NSUserDefaults standardUserDefaults] setObject:_telephone forKey:INNJUSERTELEPHONEKEY];
    
}
@end
