//
//  ElectricViewController.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/9.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "ElectricViewController.h"

@interface ElectricViewController ()


@property (nonatomic,assign) CGFloat buttonWidth;//按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//按钮的高度
@property (nonatomic,assign) CGFloat buttonTop;//第一个按钮的高度
@property (nonatomic,assign) CGFloat buttonLeft;//第一个按钮左边
@property (nonatomic,assign) CGFloat buttonIntervalX;//图标之间的间隔X轴
@property (nonatomic,assign) CGFloat buttonIntervalY;//图标之间的间隔Y轴
@end

@implementation ElectricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ElectricBackground"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
    
    
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.14;
    self.buttonWidth =  self.buttonHeigh;

    
    //初始化图标
    [self setupButtons];
    

    //排列图标
    WS(ws);
    
    [self.airVolumeAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.17);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop  * 0.15);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.moviePowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.07);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.6);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    [self.airVolumeReduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.volumeAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.07);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.6);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.volumeZeroButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.17);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.15);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.volumeReduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    
    
    
}
- (UIButton *)electricImage:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    UIButton *button = [[GWTool sharedGWTool] setupButton4:[UIImage imageNamed:image] selectImage:[UIImage imageNamed:selectedImage]];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(clickButtonDown:) forControlEvents:UIControlEventTouchDown];
    button.tag = tag;
    [self.view addSubview:button];
    return  button;
}
- (void)setupButtons
{
    

    
    //添加按钮
    self.moviePowerButton = [self electricImage:@"02电器_03" selectedImage:@"02电器_03-1" tag:SHElectricTypeMoviePower];
    
    self.airVolumeAddButton = [self electricImage:@"02电器_03-3" selectedImage:@"02电器_03-9" tag:SHElectricTypeAirVolumeAdd];
    
    self.airVolumeReduceButton = [self electricImage:@"02电器_03-5" selectedImage:@"02电器_03-8" tag:SHElectricTypeAirVolumeReduce];
    
    self.volumeAddButton = [self electricImage:@"02电器_03-2" selectedImage:@"02电器_03-7" tag:SHElectricTypeVolumeAdd];
    
    self.volumeZeroButton = [self electricImage:@"02电器_03-4" selectedImage:@"02电器_03-11" tag:SHElectricTypeVolumeZero];
    
    self.volumeReduceButton = [self electricImage:@"02电器_03-6" selectedImage:@"02电器_03-10" tag:SHElectricTypeVolumeReduce];
    
}
- (void)clickButtonDown:(UIButton *)button
{
    
    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHElectricTypeMoviePower:
            [[SHSocket sharedSHSocket] sendSocket:@"0114"];
            break;
        case SHElectricTypeAirVolumeAdd:
            [[SHSocket sharedSHSocket] sendSocket:@"0122"];
            break;
        case SHElectricTypeAirVolumeReduce:
            [[SHSocket sharedSHSocket] sendSocket:@"0123"];
            break;
            
        case SHElectricTypeVolumeAdd:
            [[SHSocket sharedSHSocket] sendSocket:@"01B1"];
            break;
            
        case SHElectricTypeVolumeZero:
            [[SHSocket sharedSHSocket] sendSocket:@"01B2"];
            break;

        case SHElectricTypeVolumeReduce:
            [[SHSocket sharedSHSocket] sendSocket:@"01B3"];
            break;

        
            
        default:
            break;
    }
    
    
}
- (void)clickButton:(UIButton *)button
{

    switch (button.tag) {
        case SHElectricTypeMoviePower:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0114"];
            break;
        case SHElectricTypeAirVolumeAdd:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0122"];
            break;
        case SHElectricTypeAirVolumeReduce:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0123"];
            break;
            
        case SHElectricTypeVolumeAdd:
            [[SHSocket sharedSHSocket] sendSocketUp:@"01B1"];
            break;
            
        case SHElectricTypeVolumeZero:
            [[SHSocket sharedSHSocket] sendSocketUp:@"01B2"];
            break;
            
        case SHElectricTypeVolumeReduce:
            [[SHSocket sharedSHSocket] sendSocketUp:@"01B3"];
            break;
            
        default:
            break;
    }
    
    
    
}

@end
