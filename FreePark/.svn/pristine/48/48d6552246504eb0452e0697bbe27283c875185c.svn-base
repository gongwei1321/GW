//
//  ShareView.m
//  AURA
//
//  Created by 龚伟 on 15/9/10.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ShareAlterViewNodelete.h"
@interface ShareAlterViewNodelete()
@property (nonatomic,strong) UIButton *maskView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinConstraint2;

@end
@implementation ShareAlterViewNodelete

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.cancelButton.layer.cornerRadius = 5.0f;
    
    
   
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat screenWidth =   self.frame.size.width;
    NSLog(@"%f",screenWidth);
    self.weixinConstraint.constant = (screenWidth/2 -  29 -59)/2;
    self.weixinConstraint2.constant = (screenWidth/2 -  29 -59)/2;
    //    self.weixinConstraint.constant = 10;
    [self layoutIfNeeded];
}

- (IBAction)clickToShare:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(chooseShareNodeleteTypeAtIndex:)])
    {
        [self.delegate chooseShareNodeleteTypeAtIndex:button.tag];
    }
}
- (IBAction)clickToAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(chooseActionNodeleteAtIndex:)])
    {
        [self.delegate chooseActionNodeleteAtIndex:button.tag];
    }
}
- (void)showView
{
    if (self.supperVC != nil) {
        if (self.maskView == nil) {
            self.maskView = [[UIButton alloc] init];
            self.maskView.backgroundColor = [UIColor blackColor];
            self.maskView.alpha = 0.3;
            self.maskView.frame = CGRectMake(0, 0, self.supperVC.view.frame.size.width, self.supperVC.view.frame.size.height);
            [self.maskView addTarget:self action:@selector(clickMaskView) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.supperVC.navigationController.view insertSubview: self.maskView belowSubview:self];
        [UIView animateWithDuration:0.3f animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -180);
        }];
    }
}
- (void)clickMaskView
{
    [self hideView];
}
- (void)hideView
{
    if (self.supperVC != nil) {
        [UIView animateWithDuration:0.3f animations:^{
            self.transform = CGAffineTransformIdentity;
            [self.maskView removeFromSuperview];
            self.maskView = nil;
        } completion:^(BOOL finished) {

        }];
    }
}
@end
