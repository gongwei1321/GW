//
//  AddCSParkHireViewController.m
//  FreePark
//
//  Created by 龚伟 on 2017/8/20.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import "AddCSParkHireViewController.h"
#import "ShareParkPlacePickVC.h"
#import "YCPickerView.h"
#import "ParkHireRequest.h"
#define MAX_LIMIT_NUMS     100 //来限制最大输入只能100个字符
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
@interface AddCSParkHireViewController ()<UITextViewDelegate,ShareParkPlacePickVCDelegate>
{
    YCPickerView *ycPickerView;
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet UITextView *miaosuTextView;
@property (weak, nonatomic) IBOutlet UILabel *miaosuLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *carPlaceTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *rentMoneyTextFiled;

@property (weak, nonatomic) IBOutlet UIButton *xiaoquButton;
@property (nonatomic,strong)  UIView *addCSMaskView;;
@property (nonatomic,assign)  NSUInteger index;

@property (weak, nonatomic) IBOutlet UITextField *placePtTF;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic) CLLocationCoordinate2D choosedPosition;
@property (weak, nonatomic) IBOutlet UILabel *lbNums;
@property (weak, nonatomic) IBOutlet UITextField *beginTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeField;
@property (weak, nonatomic) IBOutlet UIButton *xiezilouButton;
@property (weak, nonatomic) IBOutlet UIButton *qitaButton;

@end

@implementation AddCSParkHireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    self.viewWidth.constant = size_screen.width;
    
    self.miaosuTextView.delegate = self;
    
    self.addCSMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.addCSMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [self.view addSubview:self.addCSMaskView];
    [self.addCSMaskView setHidden:YES];
    
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
    
    
    
    if(self.zzParkHire.parkhireId.length!=0)//这次是修改
    {
        self.contactTextFiled.text = self.zzParkHire.contact;
        self.carPlaceTextFiled.text = self.zzParkHire.parkHireName;
        self.placePtTF.text =  [NSString stringWithFormat:@"%@, %@", self.zzParkHire.mapLng,self.zzParkHire.mapLat];
        self.rentMoneyTextFiled.text = self.zzParkHire.price;
        
        
        self.beginTimeField.text = [self getDayTimeString:self.zzParkHire.beginTime];
        
        self.endTimeField.text = [self getDayTimeString:self.zzParkHire.endTime];
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
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"HH"];
        self.beginTimeField.text = @"08:00";
        self.endTimeField.text = @"18:00";
    }
}
- (void)dealKeyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
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
- (IBAction)begintimeClick:(id)sender {
    NSArray *arrData = @[@"0:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
    
    ycPickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    ycPickerView.arrPickerData = arrData;
    NSString *beginDayTime = self.beginTimeField.text;
    NSString *beginTime = beginDayTime;
    
   
   [ycPickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [arrData enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:beginTime]) {
            [ycPickerView setTime:idx];
            [ycPickerView.pickerView selectRow:idx inComponent:0 animated:YES]; //pickerview默认选中行
        }
    }];

    [self.view addSubview:ycPickerView];
    
    
    
    
    [self.addCSMaskView setHidden:NO];
    [ycPickerView popPickerView];
    
    
    
    __block AddCSParkHireViewController *blockSelf = self;
    
    ycPickerView.missBlock = ^{
        [blockSelf.addCSMaskView setHidden:YES];
    };
    
    ycPickerView.selectBlock = ^(NSString *time){
        if (time.length > 0) {
            
            [blockSelf.addCSMaskView setHidden:YES];
            
            blockSelf.beginTimeField.text = [NSString stringWithFormat:@"%@",time];
        }
    };
    
}
- (IBAction)endtimeClick:(id)sender {
    
    NSArray *arrData = @[@"0:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
    
    ycPickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    ycPickerView.arrPickerData = arrData;
    NSString *endDayTime = self.endTimeField.text;
    NSString *endTime = endDayTime;
  
    [ycPickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [arrData enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:endTime]) {
            
            [ycPickerView setTime:idx];
            [ycPickerView.pickerView selectRow:idx inComponent:0 animated:YES]; //pickerview默认选中行
        }
    }];
    
    [self.view addSubview:ycPickerView];
    [self.addCSMaskView setHidden:NO];
    [ycPickerView popPickerView];
    
    __block AddCSParkHireViewController *blockSelf = self;
    ycPickerView.missBlock = ^{
        [blockSelf.addCSMaskView setHidden:YES];
    };
    
    
    ycPickerView.selectBlock = ^(NSString *time){
        if (time.length > 0) {
            
            [blockSelf.addCSMaskView setHidden:YES];
            
            blockSelf.endTimeField.text = [NSString stringWithFormat:@"%@",time];
        }
    };
    
}
- (NSString *)getDayTimeString:(NSString *)dattime
{
    NSUInteger index = [dattime integerValue];
    return [NSString stringWithFormat:@"%02lu:00",(unsigned long)index];
}
- (void)getDayTimeIndex:(NSString *)daytime
{
    NSArray *arrData = @[@"0:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
    NSString *Time = daytime;
    
    __block AddCSParkHireViewController *blockSelf = self;
   
        [arrData enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:Time]) {
                blockSelf.index = idx;
            }
        }];
        
}
- (IBAction)okclick:(id)sender {
    
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
    [self getDayTimeIndex:self.beginTimeField.text];
    NSString * beginIndex = [NSString stringWithFormat:@"%lu",(unsigned long)self.index];
    
    [self getDayTimeIndex:self.endTimeField.text];
    NSString * endindex = [NSString stringWithFormat:@"%lu",(unsigned long)self.index];
    
    if([beginIndex integerValue]> [endindex integerValue])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择正确的结束时间"];
        return;
    }

    if (self.rentMoneyTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写租金"];
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
        [ParkHireRequest requestModifyParkHire:self.zzParkHire.parkhireId andlocation:self.carPlaceTextFiled.text andlat:[NSString stringWithFormat:@"%lf",self.choosedPosition.latitude] andlng:[NSString stringWithFormat:@"%lf",self.choosedPosition.longitude]  andparkHireType:parkHireType andisEntireRent:@"0" andbeginTime:beginIndex andendTime:endindex  andprice:self.rentMoneyTextFiled.text andcontact:self.contactTextFiled.text andparkHireRemarks:self.miaosuTextView.text andcommitUserName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret) {
            
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
        [ParkHireRequest requestAddPackHire:self.carPlaceTextFiled.text andlat:[NSString stringWithFormat:@"%lf",self.choosedPosition.latitude] andlng:[NSString stringWithFormat:@"%lf",self.choosedPosition.longitude] andparkHireType:parkHireType andisEntireRent:@"0" andbeginTime:beginIndex andendTime:endindex  andprice:self.rentMoneyTextFiled.text andcontact:self.contactTextFiled.text andparkHireRemarks:self.miaosuTextView.text andcommitUserName:[DataManager getUserName] complete:^(BOOL issuccess, NSString *ret) {
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

#pragma mark - 将某个时间转化成 时间戳

- (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return [NSString stringWithFormat:@"%ld",timeSp];
    
}
@end
