//
//  WDNavigationViewController.m
//  Wanda
//
//  Created by 万达 on 15/7/19.
//  Copyright (c) 2015年 万达. All rights reserved.
//

#import "WDNavigationViewController.h"
#import "NavigationInteractiveTransition.h"

@interface WDNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WDNavigationViewController
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮的主题
    [self setupBarButtonTheme];
    
    //3.设置返回按钮的主题
    [self setBackButtonTheme];
}
/**
 *  设置返回按钮的主题
 */
+(void)setBackButtonTheme
{
    
}
/**
 *  设置导航栏按钮的主题
 */
+ (void)setupBarButtonTheme
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
//    
//    // 1.设置按钮的背景
//    if (!iOS7) {
//        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
//    }
//    
//    // 2.设置按钮的文字样式
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[UITextAttributeTextColor] = IWBarButtonTitleColor;
//    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
//    attrs[UITextAttributeFont] = IWBarButtonTitleFont;
//    [barItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [barItem setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
//    
//    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
//    disableAttrs[UITextAttributeTextColor] = IWBarButtonTitleDisabledColor;
//    disableAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
//    [barItem setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 1.获得bar对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBarTintColor:ZZColor(255, 255, 255)];
    
    [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];
//     navBar.alpha=0.1
    
//    [navBar setBarStyle:UIBarStyleBlackTranslucent];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;;
    

    // 设置bar背景
//    [navBar setBackgroundImage:[UIImage imageNamed:@"bg2"] forBarMetrics:UIBarMetricsDefault];
    // 2.设置文字样式
     [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : ZZColor(85, 85, 85),NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"返回" higlightedImage:@"返回" target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" higlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

/**
 *  更多
 */
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
//    gesture.enabled = NO;
//    UIView *gestureView = gesture.view;
//    
//    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
//    popRecognizer.delegate = self;
//    popRecognizer.maximumNumberOfTouches = 1;
//    [gestureView addGestureRecognizer:popRecognizer];
//    
//    
//    /**
//     *  获取系统手势的target数组
//     */
//    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
//    /**
//     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
//     */
//    id gestureRecognizerTarget = [_targets firstObject];
//    /**
//     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
//     */
//    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
//    /**
//     *  通过前面的打印，我们从控制台获取出来它的方法签名。
//     */
//    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
//    /**
//     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
//     */
//    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
//    self.popRecognizer = popRecognizer;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    
    CGPoint point = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] && point.x>0;
}

@end

