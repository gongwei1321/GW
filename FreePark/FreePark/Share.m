//
//  Share.m
//  AURA
//
//  Created by 龚伟 on 15/9/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "Share.h"
#import "SVProgressHUD.h"
#import "UserRequests.h"
#import "DataManager.h"

@implementation Share
+(void)shareWithType:(SSDKPlatformType)type content:(NSString *)content defaultContent:(NSString *)defaultContent image:(UIImage *)image title:(NSString *)title url:(NSString *)urlString description:(NSString *)description result:(void (^)())result
{
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        if(type !=  SSDKPlatformTypeSinaWeibo)
        {
          [shareParams SSDKSetupShareParamsByText:content images:image url:[NSURL URLWithString:urlString] title:title type:SSDKContentTypeAuto];
        }
        else
        {
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@%@",content,urlString] images:image url:nil title:title type:SSDKContentTypeAuto];
        }
    
    if ([DataManager getUserName]) {
        [UserRequests requestAlreadyShareInfo];
    }

        [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        NSString *content;
                        if (type == SSDKPlatformSubTypeWechatSession) {
                            content = [NSString stringWithFormat:@"WechatSession"];
                        }
                        else if(type == SSDKPlatformSubTypeWechatTimeline)
                        {
                            content = [NSString stringWithFormat:@"WechatTimeline"];
                        }
                        else if(type == SSDKPlatformTypeSinaWeibo)
                        {
                            content = [NSString stringWithFormat:@"Weibo"];
                        }
                        result();
                        [SVProgressHUD showSuccessWithStatus:@"分享成功!"];
                        if ([DataManager getUserName]) {
                            [UserRequests requestAlreadyShareInfo];
                        }
                        
                    });
                    break;
                }
                case SSDKResponseStateCancel:
                    result();
                    break;
                case SSDKResponseStateFail:
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"分享失败\r\n未安装微信客户端"]];
                    });
                }
                    break;
                default:
                    break;
            }
        }];
}
@end
