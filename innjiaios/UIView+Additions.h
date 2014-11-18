//
//  UIView+Additions.h
//  CategoryTest
//
//  Created by applee app on 12-11-22.
//  Copyright (c) 2012年 app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(Additions)

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


+(id)getView;
+(id)getView:(NSInteger) index;
- (UIViewController *)superviewcontroller;


@end
