//
//  INNJViewController.h
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#define DONEBTNTAG 13123 
#define TOPOFFSET 64


@interface INNJViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD* hud;
@property (nonatomic,strong) MBProgressHUD* hudtext;
@property (nonatomic,getter = topoffset) CGFloat topoffset;
@property (nonatomic,getter = bottomoffset) CGFloat bottomoffset;
@property (nonatomic,strong) UIView *editView;
@property (nonatomic,strong) UIView *loginView;
-(void) showLoading;
-(void) dismissLoading;
-(void) showText:(NSString*) text;
-(UIView*) getDoneView:(NSInteger) tag;
-(UIView*) getEmptyView:(CGRect) rect withText:(NSString*) text;

@end
