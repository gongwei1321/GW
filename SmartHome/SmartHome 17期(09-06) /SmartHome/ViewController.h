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
#import "LeftRightViewController.h"
#import "BackDeskViewController.h"
@interface ViewController : UIViewController

@property (nonatomic,strong) MainViewController *lightVC;
@property (nonatomic,strong) MovieViewController *moviewVC;
@property (nonatomic,strong) ElectricViewController *electricVC;
@property (nonatomic,strong) DeskViewController *refineVC;
@property (nonatomic,strong) LeftRightViewController *leftRightVC;
@property (nonatomic,strong) BackDeskViewController *backDeskVC;
- (void)manageSocketMsg:(NSString *)msg;
- (void)nextPage;
- (void)backPage;
@end

