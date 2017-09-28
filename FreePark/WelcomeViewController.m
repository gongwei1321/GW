//
//  WelcomeViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/24.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainViewController.h"
#import "WDNavigationViewController.h"

#import "LoginViewController.h"
#import "FindParkVC.h"

@interface WelcomeViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIImageView *lastImageView;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    CGFloat screenWidth  = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    //scrollView
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    scrollview.showsHorizontalScrollIndicator =  NO;
    scrollview.delegate = self;
    scrollview.pagingEnabled = YES;
    scrollview.contentSize = CGSizeMake(screenWidth*3, 0);
    [self.view addSubview:scrollview];
    self.scrollview = scrollview;
    
    //pageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 30);
    self.pageControl.bounds = CGRectMake(0, 0, 100, 18);
    self.pageControl.currentPageIndicatorTintColor = ZZColor(88, 195, 218);
    [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    self.pageControl.numberOfPages = 3;
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    self.pageControl.hidden = YES;
    
    //增加三幅图
    [self addImage:0 imageName:@"WP1"];
    
    [self addImage:1 imageName:@"WP2"];
    
    [self addImage:2 imageName:@"WP3"];
}


- (void)addImage:(NSInteger)index imageName:(NSString *)imageName
{
    CGFloat screenWidth  = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.frame = CGRectMake(index * screenWidth, 0, screenWidth, screenHeight);
    [self.scrollview  addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    if(index == 2)
    {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        [imageView addGestureRecognizer:singleTap];
        self.lastImageView = imageView;

    }
    
}
- (void)imageTap
{
    if ([DataManager getUserName].length == 0) {
        LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:vc];
        
        self.view.window.rootViewController = nav;
    }else{
        FindParkVC *mainVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
        WDNavigationViewController *nav = [[WDNavigationViewController alloc] initWithRootViewController:mainVC];
        [ZZTool sharedZZTool].wdNav = nav;
        self.view.window.rootViewController = nav;
    }
    
  
}

#pragma mark scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (scrollView.contentOffset.x/self.view.frame.size.width);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat screenWidth  = self.view.frame.size.width;
    
    if(scrollView.contentOffset.x>(2*screenWidth))
    {
        [self imageTap];
    }
}
#pragma mark pageChange代理
- (void)pageChanged:(UIPageControl *)pageControl
{
    CGFloat x = (pageControl.currentPage)*self.scrollview.bounds.size.width;
    
    [self.scrollview setContentOffset:CGPointMake(x,0) animated:NO];
}

@end
