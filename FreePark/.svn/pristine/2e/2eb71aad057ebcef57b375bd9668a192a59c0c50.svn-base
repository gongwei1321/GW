//
//  NSObject+Commen.h
//  Wanda
//
//  Created by zhangwx on 15/7/24.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface NSObject (Commen)

- (NSString *)getRealGender:(NSString *)gender;

- (NSString *)getPhoneNumForShow:(NSString *)mobile;

- (UIImage *)getLocalUserIconByMemNumber:(NSString *)mem_num;

- (void)saveLocalUserIcon:(UIImage *)img ByMemNumber:(NSString *)mem_num;

@end

@interface UIView (Loading)

- (MBProgressHUD *)showLoading:(NSString *)text;
- (void)stopLoading:(MBProgressHUD *)hud;

@end

@interface UIViewController (Login)

- (BOOL)checkNeedLogin;

@end
