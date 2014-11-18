//
//  INNJUser.h
//  innjiaios
//
//  Created by wl on 14-11-11.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define INNJUSERTELEPHONEKEY @"tele"
@interface INNJUser : NSObject
@property (strong,nonatomic) NSString* telephone;
+(INNJUser*) user;
-(BOOL) isLogin;
-(void) logout;
-(void) login:(NSString*)telephone;
@end
