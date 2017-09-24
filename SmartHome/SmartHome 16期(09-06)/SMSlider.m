//
//  SMSlider.m
//  SmartHome
//
//  Created by 龚伟 on 2017/9/4.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import "SMSlider.h"

@implementation SMSlider

// 设置最大值
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame)/ 2, CGRectGetHeight(self.frame) / 2);
}
// 设置最小值
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

// 改变滑块的触摸范围
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], 10, 10);
}
@end
