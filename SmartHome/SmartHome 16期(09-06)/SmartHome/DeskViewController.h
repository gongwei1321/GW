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
 * 天窗页面的几个按钮
 */

@property (nonatomic,strong) SMButton* scuttleUpButton; //天窗上翘
@property (nonatomic,strong) SMButton* scuttleOpenButton; //天窗开
@property (nonatomic,strong) SMButton* scuttleCloseButton; //天窗关

@end
