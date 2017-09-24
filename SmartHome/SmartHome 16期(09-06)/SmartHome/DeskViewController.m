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
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.88);
    [self.view addSubview:imageView];
    
    self.buttonIntervalX = self.view.frame.size.width * 0.30;
    self.buttonIntervalY = self.view.frame.size.height * 0.024;
    self.buttonTop =  self.view.frame.size.height * 0.3;
   
    
    
    
    self.buttonHeigh =  self.view.frame.size.width * 0.25;
    self.buttonWidth =  self.buttonHeigh * 150 / 290;
    
   

    self.scuttleUpButton = [self deskImage:@"button_default9" selectedImage:@"button_pressed9" tag:SHScuttleTypeUp];
    
    
    
    self.scuttleOpenButton = [self deskImage:@"button_default10" selectedImage:@"button_pressed10" tag:SHScuttleTypeOpen];
    
    
    
    self.scuttleCloseButton = [self deskImage:@"button_default11" selectedImage:@"button_pressed11"  tag:SHScuttleTypeClose];
    
    
    
    
    
    //排列图标
    WS(ws);
    
    
    [self.scuttleUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.25);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.scuttleOpenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.05);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
//    self.scuttleOpenButton.DownBtn = self.scuttleCloseButton;
//    self.scuttleOpenButton.isDown = YES;

    [self.scuttleCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.9);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.6);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
//    self.scuttleCloseButton.upBtn = self.scuttleOpenButton;
//    self.scuttleCloseButton.isUp = YES;




}
- (SMButton *)deskImage:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    SMButton *button = [[GWTool sharedGWTool] setupButton4:[UIImage imageNamed:image] selectImage:[UIImage imageNamed:selectedImage]];
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
        case SHScuttleTypeUp:
            [[SHSocket sharedSHSocket] sendSocket:@"0105"];
            break;
        case SHScuttleTypeOpen:
            [[SHSocket sharedSHSocket] sendSocket:@"0104"];
            break;
        case SHScuttleTypeClose:
            [[SHSocket sharedSHSocket] sendSocket:@"0106"];
            break;
            
        default:
            break;
    }
    
    
}
- (void)clickButton:(UIButton *)button
{
    switch (button.tag) {
        case SHScuttleTypeUp:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0105"];
            break;
        case SHScuttleTypeOpen:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0104"];
            break;
        case SHScuttleTypeClose:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0106"];
            break;
                  
        default:
            break;
    }

    
}


@end
