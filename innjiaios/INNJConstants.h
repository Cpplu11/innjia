//
//  INNJConstants.h
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULTCOLOR [UIColor colorWithRed:156/255.0 green:200/255.0 blue:54/255.0 alpha:1.0]

@interface INNJConstants : NSObject

@end

@interface UIImage (ImageWithColor)
+(UIImage*) imageWithColor:(UIColor*)color;
@end