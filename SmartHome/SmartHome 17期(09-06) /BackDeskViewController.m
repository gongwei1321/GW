//
//  BackDeskViewController.m
//  SmartHome
//
//  Created by 龚伟 on 2017/9/5.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import "BackDeskViewController.h"

@interface BackDeskViewController ()

@end

@implementation BackDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"05座椅（后排座椅）_01"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
    self.buttonBNIntervalX = self.view.frame.size.width * 0.018;
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.1;
    self.buttonWidth =  self.buttonHeigh/169 *212;
    
    

    
    self.heatButton = [self movieImage:@"11座椅效果（后排座椅）_09-3" selectedImage:@"11座椅效果（后排座椅）_09-19" tag:SHBackDeskTypeHeat];
    
    self.tripsisButton = [self movieImage:@"11座椅效果（后排座椅）_37" selectedImage:@"11座椅效果（后排座椅）_37-1" tag:SHBackDeskTypeTripsis];
    
    self.backButton = [self movieImage:@"11座椅效果（后排座椅）_09" selectedImage:@"11座椅效果（后排座椅）_09-1" tag:SHBackDeskTypeBack];
    
    self.leftMidFrontButton = [self movieImage:@"11座椅效果（后排座椅）_03" selectedImage:@"11座椅效果（后排座椅）_03-1" tag:SHBackDeskTypeLeftMidBack];
    
    self.leftMidBackButton = [self movieImage:@"11座椅效果（后排座椅）_19" selectedImage:@"11座椅效果（后排座椅）_19-1" tag:SHBackDeskTypeLeftMidBack];
    
    self.rightMidFrontButton = [self movieImage:@"11座椅效果（后排座椅）_32" selectedImage:@"11座椅效果（后排座椅）_32-1" tag:SHBackDeskTypeRightMidFront];
    
    self.rightMidBackButton = [self movieImage:@"11座椅效果（后排座椅）_45" selectedImage:@"11座椅效果（后排座椅）_45-1" tag:SHBackDeskTypeRightMidBack];
    
    self.upDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-5" selectedImage:@"11座椅效果（后排座椅）_09-6" tag:SHBackDeskTypeUp];
    
    self.downDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-4" selectedImage:@"11座椅效果（后排座椅）_09-12" tag:SHBackDeskTypeDown];
    
    self.beiLeftDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-8" selectedImage:@"11座椅效果（后排座椅）_09-20" tag:SHBackDeskTypeBeiLeft];
    
    self.yaoLeftDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-11" selectedImage:@"11座椅效果（后排座椅）_09-17" tag:SHBackDeskTypeYaoLeft];
    
    self.tuiLeftDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-15" selectedImage:@"11座椅效果（后排座椅）_09-16" tag:SHBackDeskTypeTuiLeft];
    
    self.beiRightDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-13" selectedImage:@"11座椅效果（后排座椅）_09-14" tag:SHBackDeskTypeBeiRight];
    
    self.yaoRightDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-9" selectedImage:@"11座椅效果（后排座椅）_09-10" tag:SHBackDeskTypeYaoRight];
    
    self.tuiRightDeskButton = [self movieImage:@"11座椅效果（后排座椅）_09-7" selectedImage:@"11座椅效果（后排座椅）_09-18" tag:SHBackDeskTypeTuiRight];
    
    
    self.upDeskButton.hidden = YES;
    self.downDeskButton.hidden = YES;

    
    
    
    
    
    
    //排列图标
    WS(ws);
    
    [self.heatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.13);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tripsisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.93);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(0);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.475);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];
    
    [self.leftMidFrontButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.475);
        make.width.mas_equalTo(self.buttonWidth );
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.leftMidBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.075);
        make.width.mas_equalTo(self.buttonWidth );
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    [self.rightMidFrontButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.725);
        make.width.mas_equalTo(self.buttonWidth );
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.rightMidBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.275);
        make.width.mas_equalTo(self.buttonWidth );
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.upDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset( - self.buttonIntervalX * 0.75);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(- self.buttonTop * 0.175);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];
    
    [self.downDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.35);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(- self.buttonTop * 0.175);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];

    
    [self.beiLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset( - self.buttonIntervalX * 0.78);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.455);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];

    
    [self.yaoLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset( - self.buttonIntervalX * 0.72);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.755);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];
    
    [self.tuiLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset( - self.buttonIntervalX * 0.42);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.2);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];
    
    
    [self.beiRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.45);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.155);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];

    
    [self.yaoRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.63);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.56);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
    }];
    
    [self.tuiRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.76);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.9);
        make.width.mas_equalTo(self.buttonWidth * 0.5);
        make.height.mas_equalTo(self.buttonHeigh * 0.5);
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
- (void)clickButtonDown:(UIButton *)button
{

    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHBackDeskTypeHeat:
            [[SHSocket sharedSHSocket] sendSocket:@"0029"];
            break;
        case SHBackDeskTypeTripsis:
            [[SHSocket sharedSHSocket] sendSocket:@"002A"];
            break;
        case SHBackDeskTypeLeftMidFront:
            [[SHSocket sharedSHSocket] sendSocket:@"0004"];
            break;
        case SHBackDeskTypeLeftMidBack:
            [[SHSocket sharedSHSocket] sendSocket:@"0005"];
            break;
        case SHBackDeskTypeRightMidFront:
            [[SHSocket sharedSHSocket] sendSocket:@"0013"];
            break;
        case SHBackDeskTypeRightMidBack:
            [[SHSocket sharedSHSocket] sendSocket:@"0014"];
            break;
        case SHBackDeskTypeUp:
            break;
        case SHBackDeskTypeDown:
            break;
        case SHBackDeskTypeBeiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0022"];
            break;
        case SHBackDeskTypeYaoLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0024"];
            break;
            
        case SHBackDeskTypeTuiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0026"];
            break;
        case SHBackDeskTypeBeiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0021"];
            break;
        case SHBackDeskTypeYaoRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0023"];
            break;
        case SHBackDeskTypeTuiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0025"];
            break;

        case SHBackDeskTypeBack:
            [[GWTool sharedGWTool].vc backPage];
            break;
            
        default:
            break;
    }
}

- (void)clickButton:(UIButton *)button
{
    
    switch (button.tag) {
        case SHBackDeskTypeHeat:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0029"];
            break;
        case SHBackDeskTypeTripsis:
            [[SHSocket sharedSHSocket] sendSocketUp:@"002A"];
            break;
        case SHBackDeskTypeLeftMidFront:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0004"];
            break;
        case SHBackDeskTypeLeftMidBack:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0005"];
            break;
        case SHBackDeskTypeRightMidFront:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0013"];
            break;
        case SHBackDeskTypeRightMidBack:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0014"];
            break;
        case SHBackDeskTypeUp:
            break;
        case SHBackDeskTypeDown:
            break;
        case SHBackDeskTypeBeiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0022"];
            break;
        case SHBackDeskTypeYaoLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0024"];
            break;
            
        case SHBackDeskTypeTuiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0026"];
            break;
        case SHBackDeskTypeBeiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0021"];
            break;
        case SHBackDeskTypeYaoRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0023"];
            break;
        case SHBackDeskTypeTuiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0025"];
            break;
            
        default:
            break;
    }
}


@end
