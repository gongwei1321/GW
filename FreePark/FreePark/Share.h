//
//  Share.h
//  AURA
//
//  Created by 龚伟 on 15/9/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface Share : NSObject
+(void)shareWithType:(SSDKPlatformType)type content:(NSString *)content defaultContent:(NSString *)defaultContent image:(UIImage *)image  title:(NSString *)title url:(NSString *)urlString description:(NSString *)description result:(void(^)())result;
@end
