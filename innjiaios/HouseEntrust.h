//
//  HouseEntrust.h
//  innjiaios
//
//  Created by wl on 14-11-28.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HouseEntrust : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * shi;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * enid;

@end
