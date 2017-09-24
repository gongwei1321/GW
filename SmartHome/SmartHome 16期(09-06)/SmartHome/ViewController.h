//
//  ViewController.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/7.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ElectricViewController.h"
#import "MovieViewController.h"
#import "DeskViewController.h"
@interface ViewController : UIViewController

@property (nonatomic,strong) MainViewController *lightVC;
@property (nonatomic,strong) MovieViewController *moviewVC;
@property (nonatomic,strong) ElectricViewController *electricVC;
@property (nonatomic,strong) DeskViewController *refineVC;
- (void)manageSocketMsg:(NSString *)msg;
@end

