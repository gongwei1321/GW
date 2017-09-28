//
//  UserRequests.h
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserRequests : NSObject
/*获取服务器地址*/
+(void) requestServerIPComplete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*获取验证码接口*/
+ (void) requestRegisterSMSByVerificationCode:(NSString *)verificationCode andPhoneNumber:(NSString *)phoneNumber andSession_name:(NSString *)session_name andCaptcha:(NSString *)captcha complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*注册接口*/
+ (void) requestRegisterByUserName:(NSString *)userName andUserPwd:(NSString *)userPwd andphoneNumber:(NSString *)phoneNumber andMapLat:(NSString *)mapLat andMapLng:(NSString *)mapLng complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*登录接口*/
+ (void) requestLoginByUserName:(NSString *)userName andUserPwd:(NSString *)userPwd  complete:(void (^)(BOOL issuccess, NSString *loginTag, NSString *loginUserName)) complete;

/*激活手机*/
+ (void) requestAppCountByIMEI:(NSString *)imei andAppType:(NSString *)appType andVersion:(NSString *)version complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*Web用户登录接口*/
+ (void) requestLoginByWebUserName:(NSString *)userName andUserPwd:(NSString *)userPwd cityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *loginTag, NSString *loginUserName)) complete;

/*绑定手机号*/
+ (void) requestWebUserBindInfo:(NSString *)userName userPass:(NSString *)userPass phoneNumber:(NSString *)phoneNumber mapLat:(NSString *)mapLat mapLng:(NSString *)mapLng complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*邮箱登陆*/
+ (void)requestLoginByEmail:(NSString *)email userName:(NSString *)userName complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*找回密码*/
+ (void) requestFindBackPassWord:(NSString *)phoneNum newPass:(NSString *)newPass complete:(void (^)(BOOL issuccess, NSString *modifyTag))complete;

/*检测版本*/
+ (void) requestCheckUpdateDiscoveryByVersion:(NSString *)version complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*获取光荣榜信息*/
+ (void) requestGetAnnouncementByLat:(NSString *)lat andLng:(NSString *)lng complete:(void (^)(BOOL issuccess, NSString *ret,NSArray *resultlist)) complete;

/*公示信息*/
+ (void) requestGetPublicityByBeginValue:(NSString *)beginValue andEndValue:(NSString *)endValue lat:(NSString *)lat lng:(NSString *)lng complete:(void (^)(BOOL issuccess, NSString *ret,NSArray *resultlist)) complete;


/*增加停车场*/
+ (void) requestAddParkByLocation:(NSString *)location andCoor:(CLLocationCoordinate2D)coor andPrice:(NSString *)price andDescription:(NSString *)description andEmail:(NSString *)email andPricetype:(NSString *)pricetype andShareReason:(NSString *)shareReason  andName:(NSString *)userName complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*停车位的数据*/
+ (void) requestGetParkDetailById:(NSString *)sid andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *name
   , NSString *description,NSString *stopPrice,NSString *priceTime,NSString *sid,NSString *lastModifyTime, NSString *creator, NSNumber *hasCollected)) complete;

+ (void)requestGetParkDetailAndPositionById:(NSString *)sid andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *name, NSString *description,NSString *stopPrice,NSString *priceTime,NSString *sid,NSString *lastModifyTime, NSString *creator, NSNumber *hasCollected,NSString *lat,NSString *lng))complete;

/*检测发现页面是否有更新*/
+ (void) requestCheckUpdateDiscovery:(NSString *)guessModifyLastTime  complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*检查是否已分享*/
+ (void) requestJudgeAlreadyShare:(void(^)(BOOL hasShared)) complete;

/*标记已分享*/
+ (void) requestAlreadyShareInfo;

/*请求是否允许使用全部检查功能*/
+ (void)requestCanUseAllCheckFunc;

/*请求是否允许使用搜索检查功能*/
+ (void)requestShouldCheckShareForSearch;

/*获取用户添加停车位*/
+ (void)requestGetAllUserAdd:(NSString *)userName andBeiJingMin:(NSString *)beiJingMin andBeiJingMax:(NSString *)beiJingMax andShangHaiMin:(NSString *)shangHaiMin andShangHaiMax:(NSString *)shangHaiMax andGuangZhouMin:(NSString *)guangZhouMin andGuangZhouMax:(NSString *)guangZhouMax andShenZhenMin:(NSString *)shenZhenMin  andShenZhenMax:(NSString *)shenZhenMax complete:(void (^)(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *arrayData)) complete;

/*获取用户收藏的停车位*/
+ (void)requestGetAllUserCollect:(NSString *)userName andLastUpdateTime:(NSString *)lastUpdateTime complete:(void (^)(BOOL issuccess, NSString *ret,NSMutableArray *arrayData)) complete;

/*设置点开的小红点*/
+ (void)requestSetCollectOpenStatus:(NSString *)collectParkId andUserName:(NSString *)userName andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*获取用户点评停车位*/
+ (void)requestGetAllUserReview:(NSString *)userName andBeiJingMin:(NSString *)beiJingMin andBeiJingMax:(NSString *)beiJingMax andShangHaiMin:(NSString *)shangHaiMin andShangHaiMax:(NSString *)shangHaiMax andGuangZhouMin:(NSString *)guangZhouMin andGuangZhouMax:(NSString *)guangZhouMax andShenZhenMin:(NSString *)shenZhenMin  andShenZhenMax:(NSString *)shenZhenMax complete:(void (^)(BOOL issuccess, NSString *ret,BOOL isUpdate,NSMutableArray *arrayData)) complete;

/*提出建议*/
+ (void)requestPostSuggest:(NSString *)content andUserName:(NSString *)userName andUserMail:(NSString *)userMail complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*消除用户分享停车场红点*/
+ (void)requestPostAlreadyClickMyAddPark:(NSString *)parkId andCityIndex:(NSString *)cityIndex complete:(void (^)(BOOL issuccess, NSString *ret)) complete;


/*消除用户评论停车场红点*/
+ (void)requestPostAlreadyClickMyCommentPark:(NSString *)parkId andCityIndex:(NSString *)cityIndex andUserName:(NSString*)userName  complete:(void (^)(BOOL issuccess, NSString *ret)) complete;

/*获取图片验证码*/
+ (void)requestCreate:(NSString *)session_name  complete:(void (^)(BOOL issuccess, NSData *imageData,NSString *ret)) complete;

/*图片验证码判断*/
+ (void)requestModifyParkHire:(NSString *)session_name andCaptcha:(NSString *)captcha complete:(void (^)(BOOL issuccess, NSString *ret)) complete;


@end
