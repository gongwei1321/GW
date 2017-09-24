//
//  GWButton.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/26.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "GWButton.h"
@implementation GWButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:lable];
        self.lableBrightness = lable;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.center.x != 0)
    {
        self.lableBrightness.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.lableBrightness.bounds = CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.height * 0.3);
        self.lableBrightness.backgroundColor = [UIColor lightGrayColor];
        self.lableBrightness.alpha = 0.0;
    }

}
- (void)setBringhtness:(NSString *)brightness
{
    [self.lableBrightness setText:brightness];
    self.lableBrightness.alpha = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.lableBrightness.alpha = 0.0;
    });
}
@end
