//
//  UIBarButtonItem+MJ.m
//  itcastWeibo
//
//  Created by 万达 on 14/11/10.
//  Copyright (c) 2014年 万达. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem(MJ)
//快速创建一个显示图片的item
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon state:(int)state target:(id)target action:(SEL)action
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    if (state == 0) {
        [btn setTitle:@"返回" forState:UIControlStateNormal];
    }
    
     btn.frame = CGRectMake(0, 0, btn.currentImage.size.width+30, btn.currentImage.size.height+30);
//    [btn setTitleColor:APPTextColor forState:UIControlStateNormal];
//    [btn setTitleColor:WDColor(233, 132, 115) forState:UIControlStateHighlighted];
    /*或者
     btn.frame = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
     */
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //btn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    if(state == 0)
    {
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    else if(state == 1){
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

//    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:icon] style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 60, 60);
//    [btn setTitleColor:WDColor(255, 255, 255) forState:UIControlStateNormal];
//    [btn setTitleColor:WDColor(255, 255, 255) forState:UIControlStateHighlighted];
     btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-40);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:higlightedImage] forState:UIControlStateHighlighted];
    UIImage *normal = [UIImage imageNamed:image];
    btn.frame = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);

    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
