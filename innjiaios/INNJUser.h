//
//  INNJUser.h
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define INNJUSERTELEPHONEKEY @"tele"
#define INNJUSERTOKENKEY @"token"
@interface INNJUser : NSObject
@property (strong,nonatomic) NSString* telephone;
@property (strong,nonatomic) NSString* token;
@property (strong,nonatomic) NSString* currentid;
+(INNJUser*) user;
-(BOOL) isLogin;
-(void) logout;
-(void) login:(NSString*)telephone andToken:(NSString *) token;
@end
