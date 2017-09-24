//
//  LeftRightViewController.m
//  SmartHome
//
//  Created by 龚伟 on 2017/9/4.
//  Copyright © 2017年 龚伟. All rights reserved.
//

#import "LeftRightViewController.h"

@interface LeftRightViewController ()

@end

@implementation LeftRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"04座椅（左右座椅）_01"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.85);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
    self.buttonBNIntervalX = self.view.frame.size.width * 0.018;
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.05;
    self.buttonWidth =  self.buttonHeigh/100 *300;
    
    
    
    
    /*左椅子*/
    self.upLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-28" selectedImage:@"09座椅效果（左右座椅）_03-5" tag:SHDeskTypeLeftUp];
    
    self.downLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-27" selectedImage:@"09座椅效果（左右座椅）_03-2" tag:SHDeskTypeLeftDown];
    
    self.beiLeftLeftDeskButton = [self movieImage:@"08座椅（左右座椅）_03" selectedImage:@"08座椅（左右座椅）_03(1)" tag:SHDeskTypeLeftBeiLeft];
    
    self.yaoLeftLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-35" selectedImage:@"09座椅效果（左右座椅）_03-11" tag:SHDeskTypeLeftYaoLeft];
    
    self.tuiLeftLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-32" selectedImage:@"09座椅效果（左右座椅）_03-15" tag:SHDeskTypeLeftTuiLeft];
    
    self.beiRightLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-24" selectedImage:@"09座椅效果（左右座椅）_03-6" tag:SHDeskTypeLeftBeiRight];
    
    self.yaoRightLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-33" selectedImage:@"09座椅效果（左右座椅）_03-9" tag:SHDeskTypeLeftYaoRight];
    
    self.tuiRightLeftDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-23" selectedImage:@"09座椅效果（左右座椅）_03-13" tag:SHDeskTypeLeftTuiRight];
    
    self.upLeftDeskButton.hidden = YES;
    
    self.downLeftDeskButton.hidden = YES;
    
    
    /*右椅子*/
    self.upRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-28" selectedImage:@"09座椅效果（左右座椅）_03-5" tag:SHDeskTypeRightUp];
    
    self.downRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-27" selectedImage:@"09座椅效果（左右座椅）_03-2" tag:SHDeskTypeRightDown];
    
    self.beiLeftRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-34" selectedImage:@"09座椅效果（左右座椅）_03-7" tag:SHDeskTypeRightBeiLeft];
    
    self.yaoLeftRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-30" selectedImage:@"09座椅效果（左右座椅）_03-14" tag:SHDeskTypeRightYaoLeft];
    
    self.tuiLeftRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-30" selectedImage:@"09座椅效果（左右座椅）_03-14" tag:SHDeskTypeRightTuiLeft];
    
    self.beiRightRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-39" selectedImage:@"09座椅效果（左右座椅）_03-8" tag:SHDeskTypeRightBeiRight];
    
    self.yaoRightRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-21" selectedImage:@"09座椅效果（左右座椅）_03-12" tag:SHDeskTypeRightYaoRight];
    
    self.tuiRightRightDeskButton = [self movieImage:@"09座椅效果（左右座椅）_03-36" selectedImage:@"09座椅效果（左右座椅）_03-16" tag:SHDeskTypeRightTuiRight];
    
    self.nextPageButton = [self movieImage:@"09座椅效果（左右座椅）_03-37" selectedImage:@"09座椅效果（左右座椅）_03-3" tag:SHDeskTypeNextPage];
    
    self.leftwarmButton = [self movieImage:@"09座椅效果（左右座椅）_03-38" selectedImage:@"09座椅效果（左右座椅）_03-17" tag:SHDeskTypeLeftWarm];
    
    self.leftmassageButton = [self movieImage:@"09座椅效果（左右座椅）_03-29" selectedImage:@"09座椅效果（左右座椅）_03-18" tag:SHDeskTypeLeftMassage];
    
    self.rightwarmButton = [self movieImage:@"09座椅效果（左右座椅）_03-31" selectedImage:@"09座椅效果（左右座椅）_03-20" tag:SHDeskTypeRightWarm];
    
    self.rightmassageButton = [self movieImage:@"09座椅效果（左右座椅）_03-25" selectedImage:@"09座椅效果（左右座椅）_03-19" tag:SHDeskTypeRightMassage];
    
    
    self.upRightDeskButton.hidden = YES;
    
    self.downRightDeskButton.hidden = YES;
    
    

    //排列图标
    WS(ws);
    
    [self.leftwarmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.25);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.leftmassageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.41);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.25);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    [self.rightwarmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.25);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.rightmassageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.41);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.25);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    [self.nextPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(0);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.48);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    
    
    /*左座椅*/
    [self.upLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.4);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.45);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.downLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.45);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.beiLeftLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.15 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.beiRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.7);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.2);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoLeftLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.45 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop *  0.4);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiLeftLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.8 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.65);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    /*右桌椅*/
    [self.upRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.4);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.45);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.downRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.45);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    [self.beiLeftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.7);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset( - self.buttonTop * 0.2);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.beiRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.15 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoLeftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop *  0.4);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.45 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiLeftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.65);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.8 );
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
- (void)clickButtonDown:(UIButton *)button
{
    
    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHDeskTypeLeftUp:
            break;
        case SHDeskTypeLeftDown:
            break;
        case SHDeskTypeLeftBeiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0002"];
            break;
        case SHDeskTypeLeftYaoLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0004"];
            break;
        case SHDeskTypeLeftTuiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0006"];
            break;
        case SHDeskTypeLeftBeiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0001"];
            break;
        case SHDeskTypeLeftYaoRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0003"];
            break;
        case SHDeskTypeLeftTuiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0005"];
            break;
            
            
            
        case SHDeskTypeRightUp:
            break;
        case SHDeskTypeRightDown:
            break;
        case SHDeskTypeRightBeiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0011"];
            break;
    
        case SHDeskTypeRightYaoLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0013"];
            break;
        case SHDeskTypeRightTuiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0015"];
            break;
        case SHDeskTypeRightBeiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0012"];
            break;
            
        case SHDeskTypeRightYaoRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0014"];
            break;
        case SHDeskTypeRightTuiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0016"];
            break;
        case SHDeskTypeLeftWarm:
            [[SHSocket sharedSHSocket] sendSocket:@"0009"];
            break;
            
        case SHDeskTypeLeftMassage:
            [[SHSocket sharedSHSocket] sendSocket:@"000B"];
            break;
        case SHDeskTypeRightWarm:
            [[SHSocket sharedSHSocket] sendSocket:@"0019"];
            break;
        case SHDeskTypeRightMassage:
            [[SHSocket sharedSHSocket] sendSocket:@"001A"];
            break;



            
            
            
            
        case SHDeskTypeNextPage:
            [[GWTool sharedGWTool].vc nextPage];
            break;
            
        default:
            break;
    }
}

- (void)clickButton:(UIButton *)button
{
    
    switch (button.tag) {
        case SHDeskTypeLeftUp:
            break;
        case SHDeskTypeLeftDown:
            break;
        case SHDeskTypeLeftBeiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0002"];
            break;
        case SHDeskTypeLeftYaoLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0004"];
            break;
        case SHDeskTypeLeftTuiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0006"];
            break;
        case SHDeskTypeLeftBeiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0001"];
            break;
        case SHDeskTypeLeftYaoRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0003"];
            break;
        case SHDeskTypeLeftTuiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0005"];
            break;
            
            
            
        case SHDeskTypeRightUp:
            break;
        case SHDeskTypeRightDown:
            break;
        case SHDeskTypeRightBeiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0011"];
            break;
            
        case SHDeskTypeRightYaoLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0013"];
            break;
        case SHDeskTypeRightTuiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0015"];
            break;
        case SHDeskTypeRightBeiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0012"];
            break;
            
        case SHDeskTypeRightYaoRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0014"];
            break;
        case SHDeskTypeRightTuiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0016"];
            break;
        case SHDeskTypeLeftWarm:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0009"];
            break;
            
        case SHDeskTypeLeftMassage:
            [[SHSocket sharedSHSocket] sendSocketUp:@"000B"];
            break;
        case SHDeskTypeRightWarm:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0019"];
            break;
        case SHDeskTypeRightMassage:
            [[SHSocket sharedSHSocket] sendSocketUp:@"001A"];
            break;
            
        default:
            break;
    }
}

@end
