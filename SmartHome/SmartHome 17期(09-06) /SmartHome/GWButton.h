//
//  GWButton.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/26.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWButton : UIButton
@property (nonatomic,strong) UILabel *lableBrightness;
- (void)setBringhtness:(NSString *)brightness;
@end
