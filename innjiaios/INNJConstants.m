//
//  INNJConstants.m
//  innjiaios
//
//  Created by wl on 14-11-7.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJConstants.h"

@implementation INNJConstants

@end

@implementation UIImage (ImageWithColor)

+(UIImage*) imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *colorimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorimage;
    
}

+(UIImage*) imageCircle:(CGRect) rect withLabel:(NSString*) label
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.1 alpha:0.8].CGColor);
    CGContextSetFillColorWithColor(context, POINTCOLOR.CGColor);
    CGContextFillEllipseInRect(context, rect);
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    [label drawInRect:CGRectMake(CGRectGetWidth(rect)*0.2, CGRectGetHeight(rect)*0.2, CGRectGetWidth(rect)*0.6, CGRectGetHeight(rect)*0.6) withAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    UIImage *colorimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorimage;
}

@end