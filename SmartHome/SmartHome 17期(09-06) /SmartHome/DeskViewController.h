//
//  DeskViewController.h
//  SmartHome
//
//  Created by 龚伟 on 16/8/15.
//  Copyright © 2016年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMButton.h"
@interface DeskViewController : UIViewController
/**
 * 电器页面的几个按钮
 */

@property (nonatomic,strong) UIButton* movieButton; //影音
@property (nonatomic,strong) UIButton* airCleanButton; //空气净化
@property (nonatomic,strong) UIButton* deskOpenButton; //桌板伸出
@property (nonatomic,strong) UIButton* deskCloseButton; //桌板收回
@end
