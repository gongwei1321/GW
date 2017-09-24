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
    
    
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.05;
    self.buttonWidth =  self.buttonHeigh/130 *350;

    
    //初始化图标
    [self setupButtons];
    

    //排列图标
    WS(ws);
    
    [self.tvUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.03);
        make.width.mas_equalTo(self.buttonWidth * 1.3);
        make.height.mas_equalTo(self.buttonHeigh * 1.3);
    }];
    
    [self.tvDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.87);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.7);
        make.width.mas_equalTo(self.buttonWidth * 1.3);
        make.height.mas_equalTo(self.buttonHeigh * 1.3);
    }];
    
    
    [self.glassPulverizationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.05);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.glassUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.37);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.glassDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.79);
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
    self.tvUpButton = [self electricImage:@"02隔屏_03-2" selectedImage:@"02隔屏_03-6" tag:SHTouchScreenTypeTVUp];
    
    self.tvDownButton = [self electricImage:@"02隔屏_03-4" selectedImage:@"02隔屏_03-9" tag:SHTouchScreenTypeTVDown];
    
    self.glassPulverizationButton = [self electricImage:@"02隔屏_03" selectedImage:@"02隔屏_03-1" tag:SHTouchScreenTypeGlassPulverization];
    
    self.glassUpButton = [self electricImage:@"02隔屏_03-3" selectedImage:@"02隔屏_03-8" tag:SHTouchScreenTypeGlassUp];
    
    self.glassDownButton = [self electricImage:@"02隔屏_03-5" selectedImage:@"02隔屏_03-7" tag:SHTouchScreenTypeGlassDown];
    
}
- (void)clickButtonDown:(UIButton *)button
{
    
    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHTouchScreenTypeTVUp:
            [[SHSocket sharedSHSocket] sendSocket:@"0101"];
            break;
        case SHTouchScreenTypeTVDown:
            [[SHSocket sharedSHSocket] sendSocket:@"0102"];
            break;
        case SHTouchScreenTypeGlassPulverization:
            [[SHSocket sharedSHSocket] sendSocket:@"0111"];
            break;
            
        case SHTouchScreenTypeGlassUp:
            [[SHSocket sharedSHSocket] sendSocket:@"0103"];
            break;
            
        case SHTouchScreenTypeGlassDown:
            [[SHSocket sharedSHSocket] sendSocket:@"0104"];
            break;
            
        default:
            break;
    }
    
    
}
- (void)clickButton:(UIButton *)button
{

    switch (button.tag) {
        case SHTouchScreenTypeTVUp:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0101"];
            break;
        case SHTouchScreenTypeTVDown:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0102"];
            break;
        case SHTouchScreenTypeGlassPulverization:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0111"];
            break;
            
        case SHTouchScreenTypeGlassUp:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0103"];
            break;
            
        case SHTouchScreenTypeGlassDown:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0104"];
            break;
            
        default:
            break;
    }
    
    
    
}

@end
