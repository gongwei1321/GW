//
//  ScrollViewController.h
//  SmartHome
//
//  Created by 龚伟 on 15/7/11.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController
@property (assign,nonatomic) NSInteger offset;
- (void)manageSocketMsg:(NSString *)msg;
@end
