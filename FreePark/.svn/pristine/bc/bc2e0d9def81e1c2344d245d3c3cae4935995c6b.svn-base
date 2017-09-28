//
//  Utils.m
//  Wanda
//
//  Created by zhangwx on 15/7/22.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "Utils.h"
#import "GTMBase64.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG) strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [DESKey UTF8String];
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result;
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    result = [GTMBase64 stringByEncodingData:myData];
    
    return result;
}

+ (NSString *)buildTransactionid
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (NSString *)buildSignWithTransactionid:(NSString *)Transactionid
{
    NSMutableString *signPartFirst = [[NSMutableString alloc] init];
    [signPartFirst appendString:[Utils md5:Transactionid]];
    NSString *key = @"0CD6B3D5710015AFD4538A654F6AE343";
    [signPartFirst appendString:key];
    NSString *sign = [Utils md5:signPartFirst];
    return sign;
}

+ (void)showToastWithMessage:(NSString *)mesage
{
    UIWindow *winodw = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:winodw animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = mesage;
    hud.userInteractionEnabled = NO;
    [hud hide:NO afterDelay:2.];
}

+ (void)showHudInWindowWithMessage:(NSString *)message {
    UIWindow *winodw = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:winodw animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setDetailsLabelText:message];
    [hud hide:YES afterDelay:2];
}

@end
