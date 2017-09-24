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
#import "SMSlider.h"
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
@property (nonatomic,strong) UIImageView* topLightLeftImageView; //顶灯左边的小灯泡
@property (nonatomic,strong) UIImageView* topLightRightImageView; //顶灯右边的小灯泡
@property (nonatomic,strong) UISlider *topSilder;//顶灯的滑条
@property (nonatomic,strong) UIButton* atmosphereLightButton; //氛围灯

@property (nonatomic,strong) UIImageView* atmosphereLightLeftImageView; //氛围灯左边的小灯泡
@property (nonatomic,strong) UIImageView* atmosphereLightRightImageView; //氛围灯右边的小灯泡
@property (nonatomic,strong) UISlider *atmosphereSilder;//氛围灯的滑条


@property (nonatomic,strong) UIButton* wallLightButton; //壁灯
@property (nonatomic,strong) UIImageView* wallLightLeftImageView; //壁灯左边的小灯泡
@property (nonatomic,strong) UIImageView* wallLightRightImageView; //壁灯右边的小灯泡
@property (nonatomic,strong) UISlider *wallSilder;//壁灯的滑条

@property (nonatomic,strong) UIButton* barLightButton; //吧台灯

@property (nonatomic,strong) UIImageView* barLightLeftImageView; //吧台灯左边的小灯泡
@property (nonatomic,strong) UIImageView* barLightRightImageView; //吧台灯右边的小灯泡
@property (nonatomic,strong) UISlider *barSilder;//吧台灯的滑条

@property (nonatomic,strong) UIButton* readLightButton; //阅读灯



@end
