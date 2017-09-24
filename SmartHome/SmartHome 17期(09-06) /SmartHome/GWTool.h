//
//  GWTool.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/9.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "ScrollViewController.h"
#import "GWButton.h"
#import "SMButton.h"
@class MainViewController,ElectricViewController,MovieViewController;
@interface GWTool : NSObject
singleton_interface(GWTool)
@property (nonatomic,strong) MainViewController *mainVc;
@property (nonatomic,strong) ElectricViewController *electricVc;
@property (nonatomic,strong) MovieViewController *movieVc;
@property (nonatomic,strong) ScrollViewController *scrollVc;
@property (nonatomic,strong) ViewController *vc;


/**
 *  按钮的状态
 */
//灯光页
@property (nonatomic,assign)  int  readLightState;
@property (nonatomic,assign)  int  decorateLightState;
@property (nonatomic,assign)  int  wineLightState;
@property (nonatomic,assign)  int  curtainLightState;
@property (nonatomic,assign)  int  topLightState;
@property (nonatomic,assign)  int  atmosphereLightState;


//影音页
@property (nonatomic,assign)  int  mainswitchMovieState;

//电动电器页
@property (nonatomic,assign)  int  leftFrontCurtain1ElectricState;
@property (nonatomic,assign)  int  leftFrontCurtain2ElectricState;




@property (nonatomic,assign) BOOL isShowNotConnect;
- (UIButton *)setupButton:(UIImage *)image selectImage:(UIImage *)selectedImage ;
- (UIButton *)setupButton2:(UIImage *)image selectImage:(UIImage *)selectedImage ;
- (UIButton *)setupButton3:(UIImage *)image selectImage:(UIImage *)selectedImage ;
- (GWButton *)setupGWButton:(UIImage *)image selectImage:(UIImage *)selectedImage ;
- (UIButton*)setupButton4:(UIImage *)image selectImage:(UIImage *)selectedImage;
- (NSString *)getCurrentDeviceModel:(UIViewController *)controller;
- (void)SystemShake;//系统 震动
@end
