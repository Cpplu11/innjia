//
//  INNJConstants.h
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULTCOLOR [UIColor colorWithRed:156/255.0 green:200/255.0 blue:54/255.0 alpha:1.0]
#define POINTCOLOR [UIColor colorWithRed:0x8e/255.0 green:0xd2/255.0 blue:0xc9/255.0 alpha:0.5]
#define BGIMAGEOFF [UIImage imageNamed:@"input-bg-off"]
#define BGIMAGEON [UIImage imageNamed:@"input-bg-on"]
#define SCBGIMAGEOFF [BGIMAGEOFF resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 40, 40) resizingMode:UIImageResizingModeStretch]
#define SCBGIMAGEON [BGIMAGEON resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 20, 20) resizingMode:UIImageResizingModeStretch]

#define TEXTPADDING 10
#define EMPTYVIEW(w) [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 36)]
#define PADDING(leftw,rightw,view) view.leftView =EMPTYVIEW(leftw),view.rightView = EMPTYVIEW(rightw),view.leftViewMode=UITextFieldViewModeAlways,view.rightViewMode=UITextFieldViewModeAlways
#define PADDINGDEFAULT(view) PADDING(TEXTPADDING,TEXTPADDING,view)

#define LOGINNOTIFICATION @"login"


#define HTTPWRAPPER(url) [NSString stringWithFormat:@"http://%@",url]
@protocol INNJLoginProtocol <NSObject>
-(void) login:(NSNotification*) notification;
-(void) logout:(NSNotification*) notification;
@end

@interface INNJConstants : NSObject

@end

@interface UIImage (ImageWithColor)
+(UIImage*) imageWithColor:(UIColor*)color;
+(UIImage*) imageCircle:(CGRect) rect withLabel:(NSString*) label;
@end