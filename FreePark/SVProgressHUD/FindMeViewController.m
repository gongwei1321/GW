//
//  FindMeViewController.m
//  FreePark
//
//  Created by 龚伟 on 16/1/2.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import "FindMeViewController.h"

@interface FindMeViewController () <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation FindMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发现";

    
    //    self.webView.scrollView.bounces= NO;
    
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];

    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = ZZColor(88, 195, 218);
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    [self.view addSubview:view];

    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self.view addSubview:webView];
    self.webView = webView;
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;

    
     [ZZTool sharedZZTool].findButton.rightIcon2.hidden = YES;
    [DataManager setModifyLastTime:[self buildTransactionid]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD show];
    
    NSString *urlStr = @"http://www.122park.com/api/app/guess/index.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
   
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//    [self.webView stringByEvaluatingJavaScriptFromString:@"ondblclick = function(){return false;}"];
    
  
    
    
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if (components.count == 2 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"click"]) {
        NSString *eleIdStr = (NSString *)[components objectAtIndex:1];
        NSInteger eleId = [eleIdStr integerValue];
        
        // Do something
        
        return NO;   // Do not load request, just receive the event
    }
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}
- (NSString *)buildTransactionid
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

@end
