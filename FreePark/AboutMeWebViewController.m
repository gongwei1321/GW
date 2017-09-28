//
//  AboutMeWebViewController.m
//  FreePark
//
//  Created by 龚伟 on 16/1/2.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "AboutMeWebViewController.h"

@interface AboutMeWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    //    self.webView.scrollView.bounces= NO;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD show];
    // 1. URL 定位资源,需要资源的地址
//   NSString *urlStr = @"http://www.122park.com/api/app/about/index.html";
    NSString *urlStr = [NSString stringWithFormat:@"%@api/app/html/about.html",[DataManager serverIp]];

  
//     NSString *urlStr = @"http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
@end
