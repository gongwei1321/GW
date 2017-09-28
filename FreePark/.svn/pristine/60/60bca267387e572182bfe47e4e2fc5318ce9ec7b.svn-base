//
//  UIBarButtonItem+MJ.h
//  itcastWeibo
//
//  Created by 万达 on 14/11/10.
//  Copyright (c) 2014年 万达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJ)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon state:(int)state target:(id)target action:(SEL)action ;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action ;
/**
 *  快速创建一个item对象（内部包装一个按钮UIButton）
 *
 *  @param image           按钮图片
 *  @param higlightedImage 按钮高亮图片
 *  @param target          按钮的监听器
 *  @param action          按钮的监听器的回调方法
 *
 *  @return 创建好的item对象
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action;
@end
