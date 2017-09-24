//
//  MovieViewController.m
//  SmartHome
//
//  Created by 龚伟 on 15/7/10.
//  Copyright (c) 2015年 龚伟. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()



@property (nonatomic,assign) CGFloat buttonWidth;//按钮的宽度
@property (nonatomic,assign) CGFloat buttonHeigh;//按钮的高度
@property (nonatomic,assign) CGFloat buttonTop;//第一个按钮的高度
@property (nonatomic,assign) CGFloat buttonLeft;//第一个按钮左边
@property (nonatomic,assign) CGFloat buttonIntervalX;//图标之间的间隔X轴
@property (nonatomic,assign) CGFloat buttonIntervalY;//图标之间的间隔Y轴

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ReadLightBackground"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
    
    
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.05;
    self.buttonWidth =  self.buttonHeigh/99 *314;

    
    //初始化图标
    [self setupButtons];
    
    
    //排列图标
    WS(ws);
    
    [self.leftFrontOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.05);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.leftBackOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.37);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.rightBackOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.79);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

        
    [self.leftFrontCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.05);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.leftBackCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.37);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.rightBackCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.79);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    
    
    
    
}
- (UIButton *)movieImage:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
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
    
    self.leftFrontOpenButton = [self movieImage:@"04窗帘_03-1" selectedImage:@"04窗帘_03" tag:SHCurtainTypeLeftFrontOpen];
    
    self.leftBackOpenButton = [self movieImage:@"04窗帘_09-1" selectedImage:@"04窗帘_09" tag:SHCurtainTypeLeftBackOpen];
    
    self.rightBackOpenButton = [self movieImage:@"04窗帘_13-1" selectedImage:@"04窗帘_13" tag:SHCurtainTypeRightBackOpen];
    
    self.leftFrontCloseButton = [self movieImage:@"04窗帘_05-1" selectedImage:@"04窗帘_05" tag:SHCurtainTypeLeftFrontClose];
    
    self.leftBackCloseButton = [self movieImage:@"04窗帘_10-1" selectedImage:@"04窗帘_10" tag:SHCurtainTypeLeftBackClose];
    
    self.rightBackCloseButton = [self movieImage:@"04窗帘_14-1" selectedImage:@"04窗帘_14" tag:SHCurtainTypeRightBackClose];
    
    
}
- (void)clickButtonDown:(UIButton *)button
{
    
    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
  
        case SHCurtainTypeLeftFrontOpen:
            [[SHSocket sharedSHSocket] sendSocket:@"0107"];
            break;
        case SHCurtainTypeLeftBackOpen:
            [[SHSocket sharedSHSocket] sendSocket:@"0109"];
            break;
        case SHCurtainTypeRightBackOpen:
            [[SHSocket sharedSHSocket] sendSocket:@"010B"];
            break;
        case SHCurtainTypeLeftFrontClose:
            [[SHSocket sharedSHSocket] sendSocket:@"0108"];
            break;
            
        case SHCurtainTypeLeftBackClose:
            [[SHSocket sharedSHSocket] sendSocket:@"010A"];
            break;
        case SHCurtainTypeRightBackClose:
            [[SHSocket sharedSHSocket] sendSocket:@"010C"];
            break;
            
        default:
            break;
    }
    
}
- (void)clickButton:(UIButton *)button
{
    switch (button.tag) {
            
        case SHCurtainTypeLeftFrontOpen:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0107"];
            break;
        case SHCurtainTypeLeftBackOpen:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0109"];
            break;
        case SHCurtainTypeRightBackOpen:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010B"];
            break;
        case SHCurtainTypeLeftFrontClose:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0108"];
            break;
            
        case SHCurtainTypeLeftBackClose:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010A"];
            break;
        case SHCurtainTypeRightBackClose:
            [[SHSocket sharedSHSocket] sendSocketUp:@"010C"];
            break;
            
        default:
            break;
    }
    
    
}


@end
