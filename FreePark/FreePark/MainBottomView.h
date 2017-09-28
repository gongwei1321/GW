//
//  MainBottomView.h
//  FreePark
//
//  Created by 龚伟 on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainBottomViewDelegate <NSObject>
@optional
- (void)mainBottomViewClickedButton:(NSInteger)buttonType;
@end
@interface MainBottomView : UIView
@property (weak, nonatomic) id<MainBottomViewDelegate> delegate;
@end
