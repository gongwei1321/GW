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
    self.buttonWidth =  self.buttonHeigh;
    
    //初始化图标
    [self setupButtons];
    
    
    //排列图标
    WS(ws);
    /*左座椅*/
    [self.upLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.48);
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
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.48);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.25 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.beiRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.7);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    [self.yaoLeftLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.65 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop *  0.6);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    [self.tuiLeftLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.1 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiRightLeftDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX *0.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.95);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    /*右桌椅*/
    [self.upRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.48);
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
         make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.beiRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.48);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.25 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoLeftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.3);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop *  0.6);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.yaoRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.38);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.65 );
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiLeftRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX *0.25);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.95);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.tuiRightRightDeskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.1 );
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
    
    
    
    
    /*左椅子*/
    self.upLeftDeskButton = [self movieImage:@"04座椅_03-4" selectedImage:@"04座椅_03-22" tag:SHDeskTypeLeftUp];
    
    self.downLeftDeskButton = [self movieImage:@"04座椅_03-2" selectedImage:@"04座椅_03-26" tag:SHDeskTypeLeftDown];
    
    self.beiLeftLeftDeskButton = [self movieImage:@"04座椅_03-7" selectedImage:@"04座椅_03-29" tag:SHDeskTypeLeftBeiLeft];
    
    self.yaoLeftLeftDeskButton = [self movieImage:@"04座椅_03-11" selectedImage:@"04座椅_03-24" tag:SHDeskTypeLeftYaoLeft];
    
    self.tuiLeftLeftDeskButton = [self movieImage:@"04座椅_03-15" selectedImage:@"04座椅_03-27" tag:SHDeskTypeLeftTuiLeft];
    
    self.beiRightLeftDeskButton = [self movieImage:@"04座椅_03-5" selectedImage:@"04座椅_03-23" tag:SHDeskTypeLeftBeiRight];
    
    self.yaoRightLeftDeskButton = [self movieImage:@"04座椅_03-10" selectedImage:@"04座椅_03-25" tag:SHDeskTypeLeftYaoRight];
    
    self.tuiRightLeftDeskButton = [self movieImage:@"04座椅_03-13" selectedImage:@"04座椅_03-31" tag:SHDeskTypeLeftTuiRight];
    

    /*右椅子*/
    self.upRightDeskButton = [self movieImage:@"04座椅_03-4" selectedImage:@"04座椅_03-22" tag:SHDeskTypeRightUp];
    
    self.downRightDeskButton = [self movieImage:@"04座椅_03-2" selectedImage:@"04座椅_03-26" tag:SHDeskTypeRightDown];
    
    self.beiLeftRightDeskButton = [self movieImage:@"04座椅_03-6" selectedImage:@"04座椅_03-30" tag:SHDeskTypeRightBeiLeft];
    
    self.yaoLeftRightDeskButton = [self movieImage:@"04座椅_03-9" selectedImage:@"04座椅_03-21" tag:SHDeskTypeRightYaoLeft];
    
    self.tuiLeftRightDeskButton = [self movieImage:@"04座椅_03-14" selectedImage:@"04座椅_03-28" tag:SHDeskTypeRightTuiLeft];
    
    self.beiRightRightDeskButton = [self movieImage:@"04座椅_03-8" selectedImage:@"04座椅_03-19" tag:SHDeskTypeRightBeiRight];
    
    self.yaoRightRightDeskButton = [self movieImage:@"04座椅_03-12" selectedImage:@"04座椅_03-17" tag:SHDeskTypeRightYaoRight];
    
    self.tuiRightRightDeskButton = [self movieImage:@"04座椅_03-16" selectedImage:@"04座椅_03-18" tag:SHDeskTypeRightTuiRight];
    
    
    
}
- (void)clickButtonDown:(UIButton *)button
{
    
   

    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
    /*左椅子*/
        case SHDeskTypeLeftUp:
            [[SHSocket sharedSHSocket] sendSocket:@"0001"];
            break;
        case SHDeskTypeLeftDown:
            [[SHSocket sharedSHSocket] sendSocket:@"0002"];
            break;
        case SHDeskTypeLeftBeiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0004"];
            break;
        case SHDeskTypeLeftYaoLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0006"];
            break;
            
        case SHDeskTypeLeftTuiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0008"];
            break;
        case SHDeskTypeLeftBeiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0003"];
            break;
        case SHDeskTypeLeftYaoRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0005"];
            break;
        case SHDeskTypeLeftTuiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0007"];
            break;
            
    /*右椅子*/
        case SHDeskTypeRightUp:
            [[SHSocket sharedSHSocket] sendSocket:@"0011"];
            break;
        case SHDeskTypeRightDown:
            [[SHSocket sharedSHSocket] sendSocket:@"0012"];
            break;
        case SHDeskTypeRightBeiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0013"];
            break;
        case SHDeskTypeRightYaoLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0015"];
            break;
            
        case SHDeskTypeRightTuiLeft:
            [[SHSocket sharedSHSocket] sendSocket:@"0017"];
            break;
        case SHDeskTypeRightBeiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0014"];
            break;
        case SHDeskTypeRightYaoRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0016"];
            break;
        case SHDeskTypeRightTuiRight:
            [[SHSocket sharedSHSocket] sendSocket:@"0018"];
            break;

        default:
            break;
    }
    
}
- (void)clickButton:(UIButton *)button
{
    switch (button.tag) {
            /*左椅子*/
        case SHDeskTypeLeftUp:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0001"];
            break;
        case SHDeskTypeLeftDown:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0002"];
            break;
        case SHDeskTypeLeftBeiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0004"];
            break;
        case SHDeskTypeLeftYaoLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0006"];
            break;
            
        case SHDeskTypeLeftTuiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0008"];
            break;
        case SHDeskTypeLeftBeiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0003"];
            break;
        case SHDeskTypeLeftYaoRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0005"];
            break;
        case SHDeskTypeLeftTuiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0007"];
            break;
            
            /*右椅子*/
        case SHDeskTypeRightUp:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0011"];
            break;
        case SHDeskTypeRightDown:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0012"];
            break;
        case SHDeskTypeRightBeiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0013"];
            break;
        case SHDeskTypeRightYaoLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0015"];
            break;
            
        case SHDeskTypeRightTuiLeft:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0017"];
            break;
        case SHDeskTypeRightBeiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0014"];
            break;
        case SHDeskTypeRightYaoRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0016"];
            break;
        case SHDeskTypeRightTuiRight:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0018"];
            break;
            

            
        default:
        break;
    }
    
    
}


@end
