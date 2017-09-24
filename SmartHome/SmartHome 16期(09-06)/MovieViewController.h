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

@end
