//
//  ParkJieJingVC.m
//  FreePark
//
//  Created by zhangwx on 2017/9/10.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ParkJieJingVC.h"
#import <BaiduPanoSDK/BaiduPanoramaView.h>

@interface ParkJieJingVC ()<BaiduPanoramaViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *jiejingContentView;
@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;
@end

@implementation ParkJieJingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initJieJin];
    });
}

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initJieJin
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth([self getFixedScreenFrame]), CGRectGetHeight([self getFixedScreenFrame]));
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:frame key:kBaiduMapKey];
    self.panoramaView.delegate = self;
    [self.jiejingContentView addSubview:self.panoramaView];
    [self.panoramaView setPanoramaWithLon:self.lng lat:self.lat];
}

- (void)panoramaLoadFailed:(BaiduPanoramaView *)panoramaView error:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:nil message:@"该地区没有街景" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGRect)getFixedScreenFrame {
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    return mainScreenFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
