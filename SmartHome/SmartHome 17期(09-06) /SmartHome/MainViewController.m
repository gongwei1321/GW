//
//  MainViewController.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/9.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LightBackground"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];

    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
    self.buttonBNIntervalX = self.view.frame.size.width * 0.018;

    
    self.buttonHeigh =  self.view.frame.size.width * 0.05;
    self.buttonWidth =  self.buttonHeigh/100 *300;
    
    
    
    
    self.topLightButton = [self lightImage:@"01灯光效果_03-2" selectedImage:@"01灯光效果_03-8" tag:SHLightTypeTop];

    self.sidewallLightButton = [self lightImage:@"01灯光效果_03-5" selectedImage:@"01灯光效果_03-7" tag:SHLightTypeSideWall];
    
    self.barLightButton = [self lightImage:@"01灯光效果_03-3" selectedImage:@"01灯光效果_03-10"  tag:SHLightTypeBar];
    
    self.readLightLButton = [self lightImage:@"01灯光效果_03" selectedImage:@"01灯光效果_03-1"  tag:SHLightTypeReadL];
    
    self.readLightRButton = [self lightImage:@"00灯光_03" selectedImage:@"00灯光_03(1)"  tag:SHLightTypeReadR];
    
    self.starButton = [self lightImage:@"01灯光效果_03-4" selectedImage:@"01灯光效果_03-11"  tag:SHLightTypeStar];
    
    self.mxQCDButton = [self lightImage:@"01灯光效果_03-6" selectedImage:@"01灯光效果_03-9"  tag:SHLightTypemxQCD];

    
   
    //排列图标
    WS(ws);
 
    
    [self.readLightLButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.1);
        make.width.mas_equalTo(self.buttonWidth );
        make.height.mas_equalTo(self.buttonHeigh );
    }];
    
    
    [self.readLightRButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.22);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.54);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    [self.mxQCDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.86);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    
    [self.topLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.05);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.barLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.42);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    [self.sidewallLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.79);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];


    
       
   
}

- (UIButton *)lightImage:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
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
        case SHLightTypeTop:
            [[SHSocket sharedSHSocket] sendSocket:@"0113"];
            break;
        case SHLightTypeSideWall:
            [[SHSocket sharedSHSocket] sendSocket:@"0117"];
            break;
        case SHLightTypeBar:
            [[SHSocket sharedSHSocket] sendSocket:@"0116"];
            break;
        case SHLightTypeReadL:
            [[SHSocket sharedSHSocket] sendSocket:@"010D"];
            break;
        case SHLightTypeReadR:
            [[SHSocket sharedSHSocket] sendSocket:@"010E"];
            break;
        case SHLightTypeStar:
            [[SHSocket sharedSHSocket] sendSocket:@"0114"];
            break;
        case SHLightTypemxQCD:
            [[SHSocket sharedSHSocket] sendSocket:@"0115"];
            break;
            
        default:
            break;
    }
}

- (void)clickButton:(UIButton *)button
{
    
    switch (button.tag) {
        case SHLightTypeTop:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0113"];
            break;
        case SHLightTypeSideWall:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0117"];
            break;
        case SHLightTypeBar:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0116"];
            break;
        case SHLightTypeReadL:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010D"];
            break;
        case SHLightTypeReadR:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010E"];
            break;
        case SHLightTypeStar:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0114"];
            break;
        case SHLightTypemxQCD:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0115"];
            break;
            
        default:
            break;
    }
}



@end
