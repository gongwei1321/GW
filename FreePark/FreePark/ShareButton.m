//
//  ShareButton.m
//  AURA
//
//  Created by 龚伟 on 15/9/10.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ShareButton.h"

@implementation ShareButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = self.bounds.size.width;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    return CGRectMake(0, titleY, self.bounds.size.width, titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    //    UIImage *image =  [self imageForState:UIControlStateNormal];
    return CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.width);
}

@end
