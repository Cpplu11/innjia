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
    MapHousePart,
    SearchHouseList,
    FavouriteHouseList
};
@interface INNJHouseListViewController : INNJViewController
@property (nonatomic,strong) NSMutableArray* data;
@property (nonatomic,assign) INNJControllerType controllertype;
@property (nonatomic,strong) UITableView* tableview;
@property (nonatomic,assign) id navdelegate;
//VillageHouseList
@property (nonatomic,strong) NSString *villagename;
//SearchHouseList
@property (nonatomic,strong) NSString *searchtext;
-(id) initWithType:(INNJControllerType) type;
-(void) bindData:(NSArray*) data;
@end
