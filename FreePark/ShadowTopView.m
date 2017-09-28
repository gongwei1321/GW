//
//  ShadowTopView.m
//  FreePark
//
//  Created by zhangwx on 2017/3/21.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ShadowTopView.h"

@implementation ShadowTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = .2;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = .2;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOpacity = .2;
    }
    return self;
}

@end
