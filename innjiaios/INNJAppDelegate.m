//
//  INNJAppDelegate.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJAppDelegate.h"
#import "DataManage.h"
#import "HouseEntrust.h"
@interface INNJAppDelegate () <BMKGeneralDelegate>
@property (nonatomic,strong) BMKMapManager *manager;
@end

@implementation INNJAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [self bMapInit];
    [self UIInit];
    return YES;
}

-(void) bMapInit
{
    _manager = [[BMKMapManager alloc] init];
    BOOL ret = [_manager start:@"vMAgWGbAEhvpHGscg5voMqXt" generalDelegate:self];
    if(!ret)
    {
        NSLog(@"Error Map AK");
    }
}
-(void) UIInit
{

    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:DEFAULTCOLOR] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

-(void) onGetNetworkState:(int)iError
{
    NSLog(@"N:%d",iError);
}

-(void) onGetPermissionState:(int)iError
{
    NSLog(@"P:%d",iError);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
