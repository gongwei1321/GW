//
//  AppDelegate.m
//  FreePark
//
//  Created by zhangwx on 15/12/12.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "AppDelegate.h"
#import "BaiduMapAll.h"
//#import "BNCoreServices.h"
#import "MainViewController.h"
#import "WDNavigationViewController.h"
#import "WelcomeViewController.h"
#import "IQKeyboardManager.h"
#import "WDHTTPTool.h"
#import "UserRequests.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "GPSManager.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "DBDataManager.h"
#import "APService.h"
#import "ZZTool.h"
#import "PublicityViewController.h"
#import "ParkRequests.h"
#import "MobClick.h"
#import "ParkDetailVC.h"

#import "LoginViewController.h"
#import "FindParkVC.h"
#import "UserRequests.h"
@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *baiduMapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initBaiduMapAndNav];
    
    [WDHTTPTool initHttps];
    
    [self initShareSDK];
    
    [self initIQKeyboardManager];
    
    [DBDataManager shareInstance];
    
    [DataManager setEnterAppTimes:[DataManager enterAppTimes]+1];
//    NSLog(@"%d",[DataManager enterAppTimes]);
 
    [self setupUMeng];
    
    [GPSManager startUpdatingLocation];
   
    // 设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [UserRequests requestServerIPComplete:^(BOOL issuccess, NSString *ret) {
        if(issuccess)
        {
            
            [DataManager setServerIP:ret];
            //是否激活
            if(![DataManager isSetAppcountAlready])
            {
                [UserRequests requestAppCountByIMEI:@"111111111111111" andAppType:@"0" andVersion:@"1.0" complete:^(BOOL issuccess, NSString *ret) {
                    if (issuccess) {
                        if ([ret isEqualToString:@"10010"]) {
                            [DataManager setAppcountAlready];
                        }
                    }
                    
                }];
            }
            
            
            //是否显示欢迎界面
            if ([DataManager isShowWelcomeAlready])
            {
                if ([DataManager getUserName].length == 0) {
                    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:vc];
                    
                    self.window.rootViewController = nav;
                }else{
                    FindParkVC *mainVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
                    WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:mainVC];
                    [ZZTool sharedZZTool].wdNav = nav;
                    self.window.rootViewController = nav;
                }
                
            }
            else{
                WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
                self.window.rootViewController = welcomeVC;
            }
            
            [DataManager setShowWelcomeAlready];
            
            
            
            [self.window makeKeyAndVisible];
            
            
            
            
            
            
            
            
            
            
            // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
                //categories
                [APService
                 registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                     UIUserNotificationTypeSound |
                                                     UIUserNotificationTypeAlert)
                 categories:nil];
            } else {
                //categories nil
                [APService
                 registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                     
                                                     
                                                     UIRemoteNotificationTypeSound |
                                                     UIRemoteNotificationTypeAlert)
#else
                 //categories nil
                 categories:nil];
                [APService
                 registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                     UIRemoteNotificationTypeSound |
                                                     UIRemoteNotificationTypeAlert)
#endif
                 // Required
                 categories:nil];
            }
            [APService setupWithOption:launchOptions];
            
            
            NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
            [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
            
            
            if (![[DataManager getUserName] isEqualToString:@""] && ([DataManager getUserName]!=nil)) {
                NSSet *set = [NSSet setWithObjects:[DataManager getUserName] , nil];
                [APService setTags:set alias:nil callbackSelector:nil object:nil];
            }
            
            [UserRequests requestCanUseAllCheckFunc];
            [UserRequests requestShouldCheckShareForSearch];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"未能获取到服务器地址，请检查网络连接"];
        }
    }];
    
    
   
    
    return YES;
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    
    
    if ([ZZTool sharedZZTool].publicityButton != nil) {
        if ([DataManager remoteNoticeNumber] == nil) {
            [DataManager setRemoteNoticeNumber:0];
        }
        NSInteger noticeNumber = [DataManager remoteNoticeNumber] + 1;
        [DataManager setRemoteNoticeNumber:noticeNumber];
        [ZZTool sharedZZTool].publicityButton.rightIcon.hidden = NO;
        [ZZTool sharedZZTool].publicityButton.numberLabel.hidden = NO;
        [ZZTool sharedZZTool].publicityButton.numberLabel.text = [NSString stringWithFormat:@"%ld",[DataManager remoteNoticeNumber]];
    }
    
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
    
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    NSString *messageid = (NSString*)[userInfo valueForKey:@"messageid"]; //服务端中Extras字段，key是自己定义的
    NSString *cityIndex = (NSString*)[userInfo valueForKey:@"cityIndex"]; //服务端中Extras字段，key是自己定义的
    NSString *sid = (NSString*)[userInfo valueForKey:@"id"]; //服务端中Extras字段，key是自己定义的
    NSString *parkName = (NSString*)[userInfo valueForKey:@"parkName"]; //服务端中Extras字段，key是自己定义的
    
    [APService handleRemoteNotification:userInfo];
    
    if ([ZZTool sharedZZTool].wdNav != nil) {
        [[ZZTool sharedZZTool].wdNav popToRootViewControllerAnimated:NO];
        if ([messageid isEqualToString:@""] || messageid == nil) {
            PublicityViewController *publicityVC = [[PublicityViewController alloc] init];
            [[ZZTool sharedZZTool].wdNav pushViewController:publicityVC animated:YES];
            
        }
        else{
            [[ZZTool sharedZZTool].wdNav popToRootViewControllerAnimated:NO];
            ParkDetailVC *detailVC = [[ParkDetailVC alloc] initWithNibName:@"ParkDetailVC" bundle:nil];
            [UserRequests requestGetParkDetailById:sid andCityIndex:cityIndex complete:^(BOOL issuccess, NSString *name, NSString *description, NSString *stopPrice, NSString *priceTime, NSString *sid,NSString *lastModifyTime,NSString *creator,NSNumber *hasCollected) {
                if (issuccess) {
                    ParkEntity *entity = [[ParkEntity alloc] init];
                    entity.parkName = name;
                    entity.parkDescription = description;
                    if(![stopPrice isEqualToString:@""])
                    {
                        entity.parkStopprice = stopPrice;
                        if (![stopPrice containsString:@"/"]) {
                            entity.parkStopprice = [NSString stringWithFormat:@"%@元/小时",stopPrice];
                        }
                    }
                    else{
                        entity.parkStopprice = priceTime;
                        if (![priceTime containsString:@"/"]) {
                            entity.parkStopprice = [NSString stringWithFormat:@"%@元/次",priceTime];
                        }
                    }
                    entity.parPriceTime = priceTime;
                    entity.parkId = sid;
                    entity.cityIndex = cityIndex;
                    entity.hasCollected = hasCollected;
                    detailVC.parkEntity = entity;
                    [[ZZTool sharedZZTool].wdNav  pushViewController:detailVC animated:YES];
                }
                else{
                    [SVProgressHUD showErrorWithStatus:@"获取停车场详情失败!"];
                }
            }];
            
        }
    }

    
    
    
}
- (void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;
    
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = NO;

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
       [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark 百度地图及导航

- (void)initBaiduMapAndNav
{
    self.baiduMapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.baiduMapManager start:kBaiduMapKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
//    [BNCoreServices_Instance initServices:kBaiduMapKey];//导航
//    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
}

#pragma mark ShareSDK

- (void)initShareSDK
{
    [ShareSDK registerApp:@"e23200ca92d2"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"392685176"
                                           appSecret:@"c3c170e2ccd69bc47397a0f408ddcfc9"
                                         redirectUri:@"https://api.weibo.com/oauth2/default.html"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxdc9adc5c6a1aba40"
                                       appSecret:@"c8b8048be0f07b83dbaf14024891a06c"];

                 break;
             default:
                 break;
         }
     }];
}

- (void)setupUMeng
{
    [MobClick startWithAppkey:@"56a581e467e58e92a60009e3"];
    [MobClick checkUpdate];
}

@end
