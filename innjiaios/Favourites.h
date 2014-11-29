//
//  Favourites.h
//  innjiaios
//
//  Created by wl on 14-11-28.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favourites : NSManagedObject

@property (nonatomic, retain) NSString * aid;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * village;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * price;

@end
