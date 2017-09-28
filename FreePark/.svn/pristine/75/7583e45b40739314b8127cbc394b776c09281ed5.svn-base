//
//  ParkPaopaoView.m
//  FreePark
//
//  Created by zhangwx on 15/12/13.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkPaopaoView.h"

@implementation ParkPaopaoView

+ (instancetype) instanceFromNib
{
    ParkPaopaoView *view = [[NSBundle mainBundle] loadNibNamed:@"ParkPaopaoView" owner:nil options:nil][0];
    view.layer.cornerRadius = 4;
    return view;
}

- (void)showAnimation:(void (^)(void))complete
{
    self.superview.layer.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.superview.layer removeAllAnimations];
        self.superview.layer.hidden = NO;
    });
    
    
    self.contentView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.bounds), 0);
    
    [UIView animateWithDuration:.3 delay:.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

@end
