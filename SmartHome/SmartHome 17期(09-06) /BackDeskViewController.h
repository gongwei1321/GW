//
//  BackDeskViewController.h
//  SmartHome
//
//  Created by 龚伟 on 2017/9/5.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackDeskViewController : UIViewController
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


@property (nonatomic,strong) UIButton* heatButton; //加热
@property (nonatomic,strong) UIButton* tripsisButton; //按摩
@property (nonatomic,strong) UIButton* backButton; //按摩

@property (nonatomic,strong) UIButton* leftMidFrontButton; //左中排前移
@property (nonatomic,strong) UIButton* leftMidBackButton; //左中排后移
@property (nonatomic,strong) UIButton* rightMidFrontButton; //右中排前移
@property (nonatomic,strong) UIButton* rightMidBackButton; //右中排后移


@property (nonatomic,strong) UIButton* upDeskButton; //上
@property (nonatomic,strong) UIButton* downDeskButton;// 下
@property (nonatomic,strong) UIButton* beiLeftDeskButton; //背部左移
@property (nonatomic,strong) UIButton* yaoLeftDeskButton;// 腰部左移
@property (nonatomic,strong) UIButton* tuiLeftDeskButton;// 腿左移
@property (nonatomic,strong) UIButton* beiRightDeskButton; //背部右移
@property (nonatomic,strong) UIButton* yaoRightDeskButton;// 腰部右移
@property (nonatomic,strong) UIButton* tuiRightDeskButton;// 腿右移
@end
