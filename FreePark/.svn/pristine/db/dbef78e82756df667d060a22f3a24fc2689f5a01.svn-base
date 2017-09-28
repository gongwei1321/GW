//
//  NavigationInteractiveTransition.h
//  UIScreenEdgePanGestureRecognizer
//
//  Created by 龚伟 on 15/6/30.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//  专门处理交互对象

#import <UIKit/UIKit.h>

@class UIViewController, UIPercentDrivenInteractiveTransition;
@interface NavigationInteractiveTransition : NSObject <UINavigationControllerDelegate>
- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;
@end
