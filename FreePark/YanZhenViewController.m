//
//  YanZhenViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/9/15.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "YanZhenViewController.h"
#import "UserRequests.h"
@interface YanZhenViewController ()
@property (nonatomic,strong) UIImageView *imageViewYZ;
@property (nonatomic,strong) UITextField *yzTextFiled;
@end

@implementation YanZhenViewController

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
    tipLabel.text = @"请输入右侧图片中的字符";
    [tipLabel setTextColor:[UIColor colorWithRed:174.0/255 green:180.0/255 blue:210.0/255 alpha:1]];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.center = CGPointMake(whiteView.frame.size.width/2, 16);
    tipLabel.bounds = CGRectMake(0, 0, whiteView.frame.size.width, 20);
    [whiteView addSubview:tipLabel];
    
    UITextField *yzTextFiled = [[UITextField alloc] init];
    yzTextFiled.center = CGPointMake(whiteView.frame.size.width * 0.4 , 50);
    yzTextFiled.bounds = CGRectMake(0, 0, whiteView.frame.size.width * 0.6, 30);
    yzTextFiled.layer.borderColor= [UIColor grayColor].CGColor;
    yzTextFiled.layer.borderWidth= 1.0f;
    [yzTextFiled becomeFirstResponder];
    self.yzTextFiled = yzTextFiled;
    
    [whiteView addSubview:yzTextFiled];
    
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(2, 5, 40, 25);
    [doneBtn addTarget:self action:@selector(dealKeyboardHide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBtn,doneBtnItem,nil];
    [topView setItems:buttonsArray];
    
    yzTextFiled.inputAccessoryView = topView;
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.yzTextFiled];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    //imageView.backgroundColor = [UIColor redColor];
    imageView.center = CGPointMake(whiteView.frame.size.width * 0.7 + 35, 50);
    imageView.bounds = CGRectMake(0, 0, 60, 30);
    [whiteView addSubview:imageView];
    [imageView setUserInteractionEnabled:YES];
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickYz:)]];
    self.imageViewYZ = imageView;
    
    
   UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
   OKBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
   [OKBtn setTitleColor:[UIColor colorWithRed:142.0/255 green:175.0/255 blue:254.0/255 alpha:1] forState:UIControlStateNormal];
   [OKBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
   OKBtn.center = CGPointMake(whiteView.frame.size.width * 0.5, 85);
   OKBtn.bounds = CGRectMake(0, 0, 40, 20);
   [whiteView addSubview:OKBtn];

    
    [UserRequests requestCreate:self.userName complete:^(BOOL issuccess, NSData *imageData, NSString *ret) {
        if(issuccess)
        {
            UIImage *image = [UIImage imageWithData: imageData];
            imageView.image  = image;
        }
    }];

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
    if(self.yzTextFiled.text.length !=4)
    {
        [SVProgressHUD showErrorWithStatus:@"输入的验证码长度不正确!"];
        return;
    }
    [SVProgressHUD show];
    [UserRequests requestModifyParkHire:self.userName andCaptcha:self.yzTextFiled.text complete:^(BOOL issuccess, NSString *ret) {
        if(issuccess)
        {
            if([ret isEqualToString:@"1"])
            {
                [SVProgressHUD dismiss];
                // 1.添加字典, 将数据包到字典中
                
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.yzTextFiled.text,@"YanZheng", nil];
                
                // 2.创建通知
                
                NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:dict];
                
                // 3.通过 通知中心 发送 通知
                
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                [self.view removeFromSuperview];
                [self removeFromParentViewController];

            }
            else{
                [SVProgressHUD showErrorWithStatus:@"输入的验证码错误!"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"异常错误"];
        }
    }];
    
}
-(void)clickYz:(UITapGestureRecognizer *)gestureRecognizer
{
    [UserRequests requestCreate:self.userName complete:^(BOOL issuccess, NSData *imageData, NSString *ret) {
        if(issuccess)
        {
            UIImage *image = [UIImage imageWithData: imageData];
            self.imageViewYZ.image  = image;
        }
        
    }];

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
