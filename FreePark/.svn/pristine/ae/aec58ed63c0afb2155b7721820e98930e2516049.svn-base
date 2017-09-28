//
//  ShareView.h
//  AURA
//
//  Created by 龚伟 on 15/9/10.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareButton.h"
@protocol ShareAlterViewNodeleteDelegate <NSObject>
- (void)chooseShareNodeleteTypeAtIndex:(NSInteger)index;
- (void)chooseActionNodeleteAtIndex:(NSInteger)index;
@end

@interface ShareAlterViewNodelete : UIView
@property (nonatomic,strong) UIViewController *supperVC;
@property (weak, nonatomic) IBOutlet ShareButton *cancelButton;
@property (nonatomic, weak) id<ShareAlterViewNodeleteDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxShareBWidth;
- (void)showView;
- (void)hideView;
@end
