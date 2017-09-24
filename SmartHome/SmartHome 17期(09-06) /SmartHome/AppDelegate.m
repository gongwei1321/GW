//
//  AppDelegate.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/7.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SHSocket sharedSHSocket].socketHost = @"10.10.100.254";// host设定
    [SHSocket sharedSHSocket].socketPort = 8899;// port设定
//    [SHSocket sharedSHSocket].socketHost = @"192.168.0.110";// host设定
//    [SHSocket sharedSHSocket].socketPort = 60000;// port设定
    
    // 在连接前先进行手动断开
    [SHSocket sharedSHSocket].socket.userData = SocketOfflineByUser;
    [[SHSocket sharedSHSocket] cutOffSocket];
    
    // 确保断开后再连，如果对一个正处于连接状态的socket进行连接，会出现崩溃
    [SHSocket sharedSHSocket].socket.userData = SocketOfflineByServer;
    [[SHSocket sharedSHSocket] socketConnectHost];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
