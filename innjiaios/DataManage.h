//
//  DateManage.h
//  IndoorNavigation
//
//  Created by wl on 14-5-17.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define DBNAME @"sql.sqlite"

@interface DataManage : NSObject

+(DataManage*)instance;
//coredata
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) saveContext;
-(NSURL *) applicationDocumentsDirectory;

@end
