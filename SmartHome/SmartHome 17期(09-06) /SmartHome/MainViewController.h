//
//  MainViewController.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/9.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWButton.h"
#import "SMButton.h"
@interface MainViewController : UIViewController
/**
 *  灯光页的几个按钮
 */





@property (nonatomic,assign) CGFloat buttonWidth;//普通按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//普通按钮的高度
@property (nonatomic,assign) CGFloat buttonWidth2;//普通按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh2;//普通按钮的高度
@property (nonatomic,assign) CGFloat buttonWidth3;//普通按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh3;//普通按钮的高度
@property (nonatomic,assign) CGFloat buttonHomeWidth;//最后一个按钮的宽度
@property (nonatomic,assign) CGFloat buttonHomeHeight;//最后一个按钮的高度
@property (nonatomic,assign) CGFloat buttonIntervalX;//图标之间的间隔X轴
@property (nonatomic,assign) CGFloat buttonIntervalY;//图标之间的间隔Y轴
@property (nonatomic,assign) CGFloat buttonTop;//第一个图标的高度
@property (nonatomic,assign) CGFloat buttonBNIntervalX;//加减与大按钮的X距离
@property (nonatomic,assign) CGFloat buttonBNIntervalY;//加减与大按钮的Y距离






@property (nonatomic,strong) UIButton* topLightButton; //顶灯
@property (nonatomic,strong) UIButton* sidewallLightButton; //侧墙灯
@property (nonatomic,strong) UIButton* barLightButton; //吧台灯
@property (nonatomic,strong) UIButton* readLightLButton; //阅读灯L
@property (nonatomic,strong) UIButton* readLightRButton; //阅读灯R
@property (nonatomic,strong) UIButton* starButton; //星光灯
@property (nonatomic,strong) UIButton* mxQCDButton; //七彩灯
@end
