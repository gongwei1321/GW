//
//  MainButton.m
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "MainButton.h"
@interface MainButton()

@end
@implementation MainButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rightIcon = [[UIImageView alloc] init];
        self.rightIcon.image = [UIImage imageNamed:@"rightIcon"];
        [self addSubview:self.rightIcon];
        self.rightIcon.hidden = YES;
        
        self.rightIcon2 = [[UIImageView alloc] init];
        self.rightIcon2.image = [UIImage imageNamed:@"rightIcon"];
        [self addSubview:self.rightIcon2];
        self.rightIcon2.hidden = YES;

        
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        //        self.numberLabel.text = @"99+";
        self.numberLabel.font = [UIFont systemFontOfSize:8];
        self.numberLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.numberLabel];
        self.numberLabel.hidden = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.rightIcon = [[UIImageView alloc] init];
        self.rightIcon.image = [UIImage imageNamed:@"rightIcon"];
        [self addSubview:self.rightIcon];
        self.rightIcon.hidden = YES;
        
        self.rightIcon2 = [[UIImageView alloc] init];
        self.rightIcon2.image = [UIImage imageNamed:@"rightIcon"];
        [self addSubview:self.rightIcon2];
        self.rightIcon2.hidden = YES;
        
        
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        //        self.numberLabel.text = @"99+";
        self.numberLabel.font = [UIFont systemFontOfSize:8];
        self.numberLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.numberLabel];
        self.numberLabel.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width;
    
    //把图标放到右上角
    self.rightIcon.frame = CGRectMake(buttonW - 10, 0, 10, 10);
    
    self.rightIcon2.frame = CGRectMake(buttonW - 10, 0, 10, 10);

    
    self.numberLabel.frame =  self.rightIcon.frame;
}


//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, self.frame.size.height * 0.1, self.frame.size.width, self.frame.size.height * 0.6);
//}
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, self.frame.size.height * 0.65, self.frame.size.width, self.frame.size.height*0.4);
//}

@end
