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
 *  触屏的几个按钮
 */

@property (nonatomic,strong) UIButton* tvUpButton; //电视升
@property (nonatomic,strong) UIButton* tvDownButton; //电视降
@property (nonatomic,strong) UIButton* glassPulverizationButton; //玻璃雾化
@property (nonatomic,strong) UIButton* glassUpButton; //玻璃升
@property (nonatomic,strong) UIButton* glassDownButton; //玻璃降
@end
