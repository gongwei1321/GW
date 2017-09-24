//
//  LeftRightViewController.h
//  SmartHome
//
//  Created by 龚伟 on 2017/9/4.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftRightViewController : UIViewController
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






/*左椅子*/
@property (nonatomic,strong) UIButton* upLeftDeskButton; //上
@property (nonatomic,strong) UIButton* downLeftDeskButton;// 下
@property (nonatomic,strong) UIButton* beiLeftLeftDeskButton; //背部左边
@property (nonatomic,strong) UIButton* yaoLeftLeftDeskButton; //腰部左边
@property (nonatomic,strong) UIButton* tuiLeftLeftDeskButton; //腿部左边
@property (nonatomic,strong) UIButton* beiRightLeftDeskButton; //背部右边
@property (nonatomic,strong) UIButton* yaoRightLeftDeskButton; //腰部右边
@property (nonatomic,strong) UIButton* tuiRightLeftDeskButton; //腿部右边
/*右椅子*/
@property (nonatomic,strong) UIButton* upRightDeskButton; //上
@property (nonatomic,strong) UIButton* downRightDeskButton;// 下
@property (nonatomic,strong) UIButton* beiLeftRightDeskButton; //背部左边
@property (nonatomic,strong) UIButton* yaoLeftRightDeskButton; //腰部左边
@property (nonatomic,strong) UIButton* tuiLeftRightDeskButton; //腿部左边
@property (nonatomic,strong) UIButton* beiRightRightDeskButton; //背部右边
@property (nonatomic,strong) UIButton* yaoRightRightDeskButton; //腰部右边
@property (nonatomic,strong) UIButton* tuiRightRightDeskButton; //腿部右边

@property (nonatomic,strong) UIButton* nextPageButton; //下一页
@property (nonatomic,strong) UIButton* leftwarmButton; //左加热
@property (nonatomic,strong) UIButton* leftmassageButton; //左按摩
@property (nonatomic,strong) UIButton* rightwarmButton; //右加热
@property (nonatomic,strong) UIButton* rightmassageButton; //右按摩

@end
