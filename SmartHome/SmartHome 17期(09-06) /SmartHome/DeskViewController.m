//
//  DeskViewController.m
//  SmartHome
//
//  Created by 龚伟 on 16/8/15.
//  Copyright © 2016年 龚伟. All rights reserved.
//

#import "DeskViewController.h"

@interface DeskViewController ()
@property (nonatomic,assign) CGFloat buttonWidth;//按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//按钮的高度
@property (nonatomic,assign) CGFloat buttonIntervalX;//图标之间的间隔X轴
@property (nonatomic,assign) CGFloat buttonIntervalY;//图标之间的间隔Y轴
@property (nonatomic,assign) CGFloat buttonTop;//第一个按钮的高度
@property (nonatomic,assign) CGFloat buttonLeft;//第一个按钮左边
@end

@implementation DeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SkyLightBackground"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;

   
    
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.05;
    self.buttonWidth =  self.buttonHeigh * 316 / 116;
    
  

    self.movieButton = [self deskImage:@"07电器效果png_03-1" selectedImage:@"07电器效果png_03" tag:SHElectricTypeMovie];
    
    
    self.airCleanButton = [self deskImage:@"07电器效果png_10-1" selectedImage:@"07电器效果png_10" tag:SHElectricTypeAirClean];
    
    
    self.deskOpenButton = [self deskImage:@"07电器效果png_05-1" selectedImage:@"07电器效果png_05"  tag:SHElectricTypeDeskOpen];
    
    
    self.deskCloseButton = [self deskImage:@"07电器效果png_12-1" selectedImage:@"07电器效果png_12"  tag:SHElectricTypeDeskClose];
    
    
    
    
    
    //排列图标
    WS(ws);
    
    
    [self.movieButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.03);
        make.width.mas_equalTo(self.buttonWidth * 1.1);
        make.height.mas_equalTo(self.buttonHeigh * 1.1);
    }];
    
    [self.airCleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.7);
        make.width.mas_equalTo(self.buttonWidth * 1.1);
        make.height.mas_equalTo(self.buttonHeigh * 1.1 );
    }];
    
    [self.deskOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.03);
        make.width.mas_equalTo(self.buttonWidth * 1.1);
        make.height.mas_equalTo(self.buttonHeigh * 1.1);
    }];
    
    [self.deskCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.7);
        make.width.mas_equalTo(self.buttonWidth * 1.1);
        make.height.mas_equalTo(self.buttonHeigh * 1.1);
    }];






}
- (UIButton *)deskImage:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    UIButton *button = [[GWTool sharedGWTool] setupButton4:[UIImage imageNamed:image] selectImage:[UIImage imageNamed:selectedImage]];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(clickButtonDown:) forControlEvents:UIControlEventTouchDown];
    button.tag = tag;
    [self.view addSubview:button];
    return  button;
}

- (void)clickButtonDown:(UIButton *)button
{
   [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHElectricTypeMovie:
            [[SHSocket sharedSHSocket] sendSocket:@"010F"];
            break;
        case SHElectricTypeAirClean:
            [[SHSocket sharedSHSocket] sendSocket:@"0110"];
            break;
        case SHElectricTypeDeskOpen:
            [[SHSocket sharedSHSocket] sendSocket:@"01C4"];
            break;
        case SHElectricTypeDeskClose:
            [[SHSocket sharedSHSocket] sendSocket:@"01C5"];
            break;
            
        default:
            break;
    }
    
    
}
- (void)clickButton:(UIButton *)button
{
    switch (button.tag) {
        case SHElectricTypeMovie:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010F"];
            break;
        case SHElectricTypeAirClean:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0110"];
            break;
        case SHElectricTypeDeskOpen:
            [[SHSocket sharedSHSocket] sendSocketUp:@"01C4"];
            break;
        case SHElectricTypeDeskClose:
            [[SHSocket sharedSHSocket] sendSocketUp:@"01C5"];
            break;
            
        default:
            break;
    }

    
}


@end
