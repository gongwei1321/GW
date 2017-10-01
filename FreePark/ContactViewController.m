//
//  ContactViewController.m
//  FreePark
//
//  Created by cody on 2017/10/1.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "ContactViewController.h"
#import "UserRequests.h"
@interface ContactViewController ()
@property (nonatomic,strong) UIImageView *imageViewYZ;
@property (nonatomic,strong) UITextField *yzTextFiled;
@end

@implementation ContactViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *maskView =[[UIView alloc] init];
    maskView.backgroundColor = [UIColor blackColor];
    [maskView setAlpha:0.3];
    maskView.frame = self.view.bounds;
    [self.view addSubview:maskView];
    
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.layer.cornerRadius = 8;
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [whiteView setAlpha:1];
    CGFloat width = self.view.bounds.size.width * 0.8;
    CGFloat height = 100;
    
    whiteView.frame = CGRectMake(self.view.bounds.size.width * 0.1, self.view.bounds.size.height/2 - height/2, width, height);
    [self.view  addSubview:whiteView];
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"联系方式";
    [tipLabel setTextColor:[UIColor blackColor]];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:16];
    tipLabel.center = CGPointMake(whiteView.frame.size.width/2, 16);
    tipLabel.bounds = CGRectMake(0, 0, whiteView.frame.size.width, 20);
    [whiteView addSubview:tipLabel];
    
    UILabel *contactLabel = [[UILabel alloc] init];
     contactLabel.text = self.contact;
    [contactLabel setTextColor:[UIColor colorWithRed:174.0/255 green:180.0/255 blue:210.0/255 alpha:1]];
    contactLabel.textAlignment = NSTextAlignmentCenter;
    contactLabel.font = [UIFont systemFontOfSize:14];
    contactLabel.center = CGPointMake(whiteView.frame.size.width/2, 50);
    contactLabel.bounds = CGRectMake(0, 0, whiteView.frame.size.width, 20);
    [whiteView addSubview:contactLabel];
    
   
    

    UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    OKBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [OKBtn setTitleColor:[UIColor colorWithRed:142.0/255 green:175.0/255 blue:254.0/255 alpha:1] forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    OKBtn.center = CGPointMake(whiteView.frame.size.width * 0.5, 85);
    OKBtn.bounds = CGRectMake(0, 0, 40, 20);
    [whiteView addSubview:OKBtn];
    
    
}
#pragma mark - UITextFieldDelegate
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    if (toBeString.length-1 > 3 && toBeString.length>1) {
        textField.text = [toBeString substringToIndex:4];
    }
}
-(void)btnClick
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
-(void)clickYz:(UITapGestureRecognizer *)gestureRecognizer
{
   
    
}
- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
