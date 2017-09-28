//
//  Utils.h
//  Wanda
//
//  Created by zhangwx on 15/7/22.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface Utils : NSObject

+ (NSString *) md5:(NSString *)str;
+ (NSString *)buildTransactionid;
+ (NSString *)buildSignWithTransactionid:(NSString *)Transactionid;
+ (NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

+ (void)showToastWithMessage:(NSString *)mesage;
+ (void)showHudInWindowWithMessage:(NSString *)message;

@end
