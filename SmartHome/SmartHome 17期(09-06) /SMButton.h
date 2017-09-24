//
//  SMButton.h
//  SmartHome
//
//  Created by 龚伟 on 2017/1/20.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMButton : UIButton
@property (nonatomic,strong) SMButton *upBtn;//上面的按钮
@property (nonatomic,strong) SMButton *DownBtn;//下面的按钮

@property (nonatomic,assign) BOOL isUp;//上面的按钮
@property (nonatomic,assign) BOOL isDown;//下面的按钮
@end
