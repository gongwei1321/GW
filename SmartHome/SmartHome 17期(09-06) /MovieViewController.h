//
//  MovieViewController.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/10.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMButton.h"
@interface MovieViewController : UIViewController
/**
 *  影音页的几个按钮
 */

@property (nonatomic,strong) UIButton* leftFrontOpenButton; //左前窗帘开
@property (nonatomic,strong) UIButton* leftBackOpenButton; //左后窗帘开
@property (nonatomic,strong) UIButton* rightBackOpenButton;//右后窗帘开
@property (nonatomic,strong) UIButton* leftFrontCloseButton; //左前窗帘关
@property (nonatomic,strong) UIButton* leftBackCloseButton; //左后窗帘开
@property (nonatomic,strong) UIButton* rightBackCloseButton; //右后窗帘关



@end
