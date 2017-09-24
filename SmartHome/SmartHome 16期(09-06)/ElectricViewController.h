//
//  ElectricViewController.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/9.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMButton.h"
@interface ElectricViewController : UIViewController
/**
 *  电动电器页的几个按钮
 */

@property (nonatomic,strong) UIButton* moviePowerButton; //影音总开关
@property (nonatomic,strong) UIButton* airVolumeAddButton; //空调风量+
@property (nonatomic,strong) UIButton* airVolumeReduceButton; //空调风量-
@property (nonatomic,strong) UIButton* volumeAddButton; //音量+
@property (nonatomic,strong) UIButton* volumeZeroButton; //静音
@property (nonatomic,strong) UIButton* volumeReduceButton; //音量-
@end
