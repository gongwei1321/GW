//
//  AddInterleavedViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "AddInterleavedViewController.h"
#import "ShareParkPlacePickVC.h"
#import "ParkHireRequest.h"
#define MAX_LIMIT_NUMS     100 //来限制最大输入只能100个字符
@interface AddInterleavedViewController ()<UITextViewDelegate,ShareParkPlacePickVCDelegate>
@property (weak, nonatomic) IBOutlet UITextView *miaosuTextView;
@property (weak, nonatomic) IBOutlet UILabel *miaosuLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *carPlaceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *placePtTF;
@property (weak, nonatomic) IBOutlet UILabel *lbNums;
@property (weak, nonatomic) IBOutlet UIButton *xiaoquButton;
@property (weak, nonatomic) IBOutlet UIButton *xiezilouButton;
@property (weak, nonatomic) IBOutlet UIButton *qitaButton;

@property (nonatomic,strong) UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UITextField *rentMoneyTextFiled;
@property (nonatomic) CLLocationCoordinate2D choosedPosition;
@end

@implementation AddInterleavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.miaosuTextView.delegate =self;
   
    
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
    
    self.contactTextFiled.inputAccessoryView = topView;
    self.carPlaceTextFiled.inputAccessoryView = topView;
    self.rentMoneyTextFiled.inputAccessoryView = topView;
    self.miaosuTextView.inputAccessoryView = topView;
    [self.miaosuTextView.layer setCornerRadius:6];

    self.rentMoneyTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    
    if(self.zzParkHire.parkhireId.length!=0)//这次是修改
    {
        self.contactTextFiled.text = self.zzParkHire.contact;
        self.carPlaceTextFiled.text = self.zzParkHire.parkHireName;
        self.placePtTF.text =  [NSString stringWithFormat:@"%@, %@", self.zzParkHire.mapLng,self.zzParkHire.mapLat];
        self.rentMoneyTextFiled.text = self.zzParkHire.price;
        if([self.zzParkHire.parkHireType isEqualToString:@"0"])
        {
            self.xiaoquButton.selected = YES;
            self.selectedButton = self.xiaoquButton;
        }
        else if([self.zzParkHire.parkHireType isEqualToString:@"1"])
        {
            self.xiezilouButton.selected = YES;
            self.selectedButton = self.xiezilouButton;
        }
        else if([self.zzParkHire.parkHireType isEqualToString:@"2"])
        {
            self.qitaButton.selected = YES;
            self.selectedButton = self.qitaButton;
        }
        self.miaosuTextView.text = self.zzParkHire.parkHireRemarks;
        if(self.miaosuTextView.text.length!=0)
        {
            self.miaosuLabel.hidden = YES;
        }
         self.choosedPosition = (CLLocationCoordinate2D){[self.zzParkHire.mapLat doubleValue],[self.zzParkHire.mapLng doubleValue]};

    }
    else{
        self.xiaoquButton.selected = YES;
        self.selectedButton = self.xiaoquButton;
    }
}

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if((textView.text.length - range.length+text.length)!= 0)
    {
        if (textView.tag == 1) {
            
            self.miaosuLabel.hidden = YES;
        }else{
            self.miaosuLabel.hidden = YES;
        }
        
    }
    else{
        if (textView.tag == 1) {
            self.miaosuLabel.hidden = NO;
        }
        else{
            self.miaosuLabel.hidden = NO;
        }
        
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }

    
    return TRUE;
    
}
- (IBAction)actionShowPlacePickView:(id)sender {
    ShareParkPlacePickVC *vc = [[ShareParkPlacePickVC alloc] initWithNibName:@"ShareParkPlacePickVC" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chooseThePlace:(CLLocationCoordinate2D)place
{
    self.choosedPosition = place;
    self.placePtTF.text = [NSString stringWithFormat:@"%lf, %lf", place.longitude, place.latitude];
}
- (IBAction)radioClick:(UIButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}



- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MIN(100,existTextNum),MAX_LIMIT_NUMS];
}
- (IBAction)okClick:(id)sender {
    
    if (self.contactTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系方式"];
        return;
    }
    if (self.carPlaceTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写车位地址"];
        return;
    }
    
    if (self.placePtTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地点坐标!"];
        return;
    }
    
    if (self.rentMoneyTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择租金"];
        return;
    }
    NSString *parkHireType = @"";
    if(self.selectedButton.tag == 1)
    {
        parkHireType = @"0";
    }
    else if(self.selectedButton.tag == 2)
    {
        parkHireType = @"1";
    }
    else if(self.selectedButton.tag == 3)
    {
        parkHireType = @"2";
    }
    
    if(self.zzParkHire.parkhireId.length!=0)//这次是修改
    {
        [ParkHireRequest requestModifyParkHire:self.zzParkHire.parkhireId andlocation:self.carPlaceTextFiled.text andlat:[NSString stringWithFormat:@"%lf",self.choosedPosition.latitude] andlng:[NSString stringWithFormat:@"%lf",self.choosedPosition.longitude]  andparkHireType:parkHireType andisEntireRent:@"1" andbeginTime:@"0"  andendTime:@"0" andprice:self.rentMoneyTextFiled.text andcontact:self.contactTextFiled.text andparkHireRemarks:self.miaosuTextView.text andcommitUserName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret) {
            
            if(issuccess)
            {
                [SVProgressHUD showSuccessWithStatus:@"已修改，请耐心等待审核!"];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"修改失败!"];
                
            }

            
        }];
    }
    else{
        [ParkHireRequest requestAddPackHire:self.carPlaceTextFiled.text andlat:[NSString stringWithFormat:@"%lf",self.choosedPosition.latitude] andlng:[NSString stringWithFormat:@"%lf",self.choosedPosition.longitude] andparkHireType:parkHireType andisEntireRent:@"1" andbeginTime:@"0" andendTime:@"0" andprice:self.rentMoneyTextFiled.text andcontact:self.contactTextFiled.text andparkHireRemarks:self.miaosuTextView.text andcommitUserName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret) {
            if([ret isEqualToString:@"130020"])
            {
                [SVProgressHUD showSuccessWithStatus:@"已提交，请耐心等待审核!"];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });

            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"提交失败!"];
                
            }
        }];

    }
    
  
}
@end
