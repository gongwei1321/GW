//
//  YCPickerView.m
//  YCPickerView
//
//  Created by 袁灿 on 16/2/29.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define PICKERVIEW_HEIGHT           256


#import "YCPickerView.h"

@interface YCPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger selectTimeRow;
    UIView *maskView;
}

@property (retain, nonatomic) UIView *baseView;
@end

@implementation YCPickerView
- (void)setTime:(NSInteger)Time
{
    selectTimeRow = Time;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
        
        UILabel *selectTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [selectTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [selectTimeLabel setFont:[UIFont systemFontOfSize:15]];
        [selectTimeLabel setText:@"选择时间"];
        [_baseView addSubview:selectTimeLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        [lineView setBackgroundColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1]];
        [_baseView addSubview:lineView];
        
        
        //
        //        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        //        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        //        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        //        [_baseView addSubview:btnCancel];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, PICKERVIEW_HEIGHT - 42 - 30)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_baseView addSubview:_pickerView];
        
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(8, PICKERVIEW_HEIGHT - 42 , SCREEN_WIDTH - 16, 30)];
       
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btnOK setBackgroundColor:[UIColor colorWithRed:139.0/255 green:194.0/255 blue:74.0/255 alpha:1]];
        [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnOK];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

#pragma mark - UIPickerViewDataSource
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
      
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}  //返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    return _arrPickerData.count;
    
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return _arrPickerData[row];
}


#pragma mark - UIPickerViewDelegate

//选中pickerView的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   selectTimeRow = row;

}

#pragma mark - Private Menthods

//弹出pickerView
- (void)popPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
    
}

//取消pickerView
- (void)dismissPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                         if (self.missBlock) {
                             self.missBlock();
                         }

                     }];
}

//确定
- (void)pickerViewBtnOK:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(_arrPickerData[selectTimeRow]);
    }
    [self dismissPickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
    
    [self dismissPickerView];
    
}


@end
