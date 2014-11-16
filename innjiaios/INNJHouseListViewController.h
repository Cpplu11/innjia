//
//  INNJHouseListViewController.h
//  innjiaios
//
//  Created by wl on 14-11-13.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJViewController.h"
typedef NS_ENUM(NSInteger, INNJControllerType)
{
    MapHouseList=1,
    VillageHouseList,
    MapHousePart
};
@interface INNJHouseListViewController : INNJViewController
@property (nonatomic,strong) NSArray* data;
@property (nonatomic,assign) INNJControllerType controllertype;
@property (nonatomic,strong) NSString *villagename;
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,assign) id navdelegate;
-(id) initWithType:(INNJControllerType) type;
-(void) bindData:(NSArray*) data;
@end
