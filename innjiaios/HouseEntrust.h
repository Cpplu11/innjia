//
//  HouseEntrust.h
//  innjiaios
//
//  Created by wl on 14-11-12.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HouseEntrust : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) NSString * shi;
@property (nonatomic, retain) NSString * date;

@end
