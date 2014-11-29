//
//  HouseDate.h
//  innjiaios
//
//  Created by wl on 14-11-26.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HouseDate : NSManagedObject

@property (nonatomic, retain) NSString * aid;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * rent;
@property (nonatomic, retain) NSString * shi;
@property (nonatomic, retain) NSString * village;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * status;

@end
