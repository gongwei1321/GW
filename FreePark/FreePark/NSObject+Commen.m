//
//  NSObject+Commen.m
//  Wanda
//
//  Created by zhangwx on 15/7/24.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "NSObject+Commen.h"

#define UserIconPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@implementation NSObject (Commen)

- (NSString *)getRealGender:(NSString *)gender
{
    if ([gender isEqualToString:@"0"]) {
        return @"其他";
    }else if([gender isEqualToString:@"1"]){
        return @"男";
    }else if([gender isEqualToString:@"2"]){
        return @"女";
    }
    return gender;
}

- (NSString *)getPhoneNumForShow:(NSString *)mobile
{
    @try {
        NSString *retStr = [mobile stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
        return retStr;
    }
    @catch (NSException *exception) {
        return mobile;
    }
}

- (UIImage *)getLocalUserIconByMemNumber:(NSString *)mem_num
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[UserIconPath stringByAppendingString:mem_num]];
    if (!data) {
        return nil;
    }
    UIImage *img = [UIImage imageWithData:data];
    return img;
}

- (void)saveLocalUserIcon:(UIImage *)img ByMemNumber:(NSString *)mem_num
{
    NSData *data = UIImageJPEGRepresentation(img, 1);
    [data writeToFile:[UserIconPath stringByAppendingString:mem_num] atomically:YES];
}

@end

@implementation UIView (Loading)

- (MBProgressHUD *)showLoading:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelText = text;
    return hud;
}

- (void)stopLoading:(MBProgressHUD *)hud
{
    [hud hide:YES];
    [hud removeFromSuperview];
}

@end

@implementation UIViewController (Login)

- (BOOL)checkNeedLogin
{
//    WDLogin *login = [WDFileTool account];
//    if (login.member_no.length == 0) {
//        LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        WDNavigationViewController *navi = [[WDNavigationViewController alloc] initWithRootViewController:vc];
//        [self.navigationController presentViewController:navi animated:YES completion:nil];
//        return NO;
//    }else{
//        return YES;
//    }
    return YES;
}

@end
