//
//  ZZTool.h
//  FreePark
//
//  Created by 龚伟 on 15/12/26.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "WDNavigationViewController.h"
#import "MainButton.h"
@interface ZZTool : NSObject
singleton_interface(ZZTool)
+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller;
@property (nonatomic,strong) WDNavigationViewController *wdNav;
@property (nonatomic,strong) MainButton *publicityButton;//公示
@property (nonatomic,strong) MainButton *findButton;//发现
@end
