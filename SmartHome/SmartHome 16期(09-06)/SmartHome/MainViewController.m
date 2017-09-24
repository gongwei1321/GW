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

    
    self.buttonHeigh =  self.view.frame.size.width * 0.095;
    self.buttonWidth =  self.buttonHeigh/200 *270;
    
    
    self.buttonHeigh2 = self.view.frame.size.width * 0.028;
    self.buttonWidth2 = self.buttonHeigh2;
    
    
    self.topLightButton = [self lightImage:@"00灯光_03-2" selectedImage:@"00灯光_03-7" tag:SHLightTypeTop];

    self.atmosphereLightButton = [self lightImage:@"00灯光_03-4" selectedImage:@"00灯光_03-6" tag:SHLightTypeAtmosphere];
    
    self.wallLightButton = [self lightImage:@"00灯光_03" selectedImage:@"00灯光_03-1"  tag:SHLightTypeWall];
    
    self.barLightButton = [self lightImage:@"00灯光_03-3" selectedImage:@"00灯光_03-8"  tag:SHLightTypeBar];
    
    self.readLightButton = [self lightImage:@"00灯光_03-5" selectedImage:@"00灯光_03-9"  tag:SHLightTypeRead];
    
    self.topLightLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03"]];
    [self.view addSubview:self.topLightLeftImageView];
    
    self.topLightRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03-2"]];
    [self.view addSubview:self.topLightRightImageView];

    self.topSilder = [self getSliderWith:SHLightTypeTop];
    
    
    self.atmosphereLightLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03"]];
    [self.view addSubview:self.atmosphereLightLeftImageView];
    
    self.atmosphereLightRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03-2"]];
    [self.view addSubview:self.atmosphereLightRightImageView];
    
    self.atmosphereSilder = [self getSliderWith:SHLightTypeAtmosphere];
    
    
    self.wallLightLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03"]];
    [self.view addSubview:self.wallLightLeftImageView];
    
    self.wallLightRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03-2"]];
    [self.view addSubview:self.wallLightRightImageView];
    
    self.wallSilder = [self getSliderWith:SHLightTypeWall];
    
    
    
    self.barLightLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03"]];
    [self.view addSubview:self.barLightLeftImageView];
    
    self.barLightRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_03-2"]];
    [self.view addSubview:self.barLightRightImageView];
    
    self.barSilder = [self getSliderWith:SHLightTypeBar];
    
    
    //排列图标
    WS(ws);
 
    
    [self.topLightLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.481);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.232);
        make.width.mas_equalTo(self.buttonWidth2);
        make.height.mas_equalTo(self.buttonHeigh2);
    }];
    
    [self.topSilder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.13);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.232);
        make.width.mas_equalTo(self.buttonWidth2 * 6.5);
        make.height.mas_equalTo(self.buttonHeigh2 * 0.5);
    }];
    
    
    [self.topLightRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset( - self.buttonIntervalX * 0.76);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.232);
        make.width.mas_equalTo(self.buttonWidth2);
        make.height.mas_equalTo(self.buttonHeigh2);
    }];

    
    
    [self.wallLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.72);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.wallLightLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.729);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(- self.buttonTop * 0.382);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];
    
    [self.wallLightRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.45);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(- self.buttonTop * 0.382);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];

    
    
    [self.wallSilder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.08);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(- self.buttonTop * 0.382);
        make.width.mas_equalTo(self.buttonWidth2 * 6.5);
        make.height.mas_equalTo(self.buttonHeigh2 * 0.5);
    }];
    

    [self.topLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.07);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-self.buttonTop * 0.52);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
   
    [self.atmosphereLightRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.61);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.032);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];
    
    [self.atmosphereLightLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1.331);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.032);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];
    
    
    [self.atmosphereSilder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 0.98);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.032);
        make.width.mas_equalTo(self.buttonWidth2 * 6.5);
        make.height.mas_equalTo(self.buttonHeigh2 * 0.5);
    }];
    
    [self.atmosphereLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(-self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.72);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];

    [self.barLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.2);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.08);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    [self.readLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 1.02);
        make.width.mas_equalTo(self.buttonWidth);
        make.height.mas_equalTo(self.buttonHeigh);
    }];
    
    
    
    [self.barLightRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.54);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.352);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];
    
    [self.barLightLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 0.819);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.352);
        make.width.mas_equalTo(self.buttonWidth2 );
        make.height.mas_equalTo(self.buttonHeigh2 );
    }];
    
    [self.barSilder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX).offset(self.buttonIntervalX * 1.17);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(self.buttonTop * 0.352);
        make.width.mas_equalTo(self.buttonWidth2 * 6.5);
        make.height.mas_equalTo(self.buttonHeigh2 * 0.5);
    }];



    
       
   
}
- (void) sliderChange:(id) sender {
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider * slider = sender;
        int value = (int)slider.value;
        
        NSString *msg;
        
        if(slider.tag == SHLightTypeTop)
        {
            msg = [NSString stringWithFormat:@"0019%@",[self ToHex:value]];
            [[SHSocket sharedSHSocket] sendSocket:msg];
            [[SHSocket sharedSHSocket] sendSocketUp:msg];
        }
        else if(slider.tag == SHLightTypeAtmosphere)
        {
            msg = [NSString stringWithFormat:@"011A%@",[self ToHex:value]];
            [[SHSocket sharedSHSocket] sendSocket:msg];
            [[SHSocket sharedSHSocket] sendSocketUp:msg];
        }
        else if(slider.tag == SHLightTypeWall)
        {
            msg = [NSString stringWithFormat:@"011B%@",[self ToHex:value]];
            [[SHSocket sharedSHSocket] sendSocket:msg];
            [[SHSocket sharedSHSocket] sendSocketUp:msg];
        }
        else if(slider.tag == SHLightTypeBar)
        {
            msg = [NSString stringWithFormat:@"011C%@",[self ToHex:value]];
            [[SHSocket sharedSHSocket] sendSocket:msg];
            [[SHSocket sharedSHSocket] sendSocketUp:msg];
        }
       
        NSLog(@"%d", value);
        //self.view.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:value];
    }
}
- (UISlider *)getSliderWith:(NSInteger)tag
{
    UISlider * slider = [[UISlider alloc] init];
    slider.tag  = tag;
    slider.minimumValue = 0;//设置最小值
    slider.maximumValue = 100;//设置最大值
    [self.view addSubview:slider];
   
    
    UIImage *imagea=[self OriginImage:[UIImage imageNamed:@"99灯光调节滑块"] scaleToSize:CGSizeMake(self.buttonWidth * 0.2, self.buttonWidth * 0.2 * 23 /52)];
    [slider  setThumbImage:imagea forState:UIControlStateNormal];
    
    slider.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    UIImage *stetchLeftTrack =  [self OriginImage:[UIImage imageNamed:@"ipad_07"] scaleToSize:CGSizeMake(self.buttonWidth2 * 6.5, self.buttonWidth * 0.2 * 23 /52 * 0.8)];
    UIImage *stetchRightTrack = [self OriginImage:[UIImage imageNamed:@"ipad_07"] scaleToSize:CGSizeMake(self.buttonWidth2 * 6.5, self.buttonWidth * 0.2 * 23 /52 * 0.8)];
    
    //设置轨道的图片
    [slider setMinimumTrackImage:[stetchLeftTrack resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[stetchRightTrack resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)] forState:UIControlStateNormal];
    
    return slider;
    
}
/*
 对原来的图片的大小进行处理
 @param image 要处理的图片
 @param size  处理过图片的大小
 */
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
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
- (NSString *)ToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    if(str.length == 1)
    {
        str = [NSString stringWithFormat:@"0%@",str];
    }
    return str;
}- (void)clickButtonDown:(UIButton *)button
{


    
    [[GWTool sharedGWTool] SystemShake];
    switch (button.tag) {
        case SHLightTypeTop:
            [[SHSocket sharedSHSocket] sendSocket:@"0078"];
            break;
        case SHLightTypeAtmosphere:
            [[SHSocket sharedSHSocket] sendSocket:@"0079"];
            break;
        case SHLightTypeWall:
            [[SHSocket sharedSHSocket] sendSocket:@"007A"];
            break;
        case SHLightTypeBar:
            [[SHSocket sharedSHSocket] sendSocket:@"007B"];
            break;
        case SHLightTypeRead:
            [[SHSocket sharedSHSocket] sendSocket:@"0113"];
            break;
            
        default:
            break;
    }
}

- (void)clickButton:(UIButton *)button
{
    
    switch (button.tag) {
        case SHLightTypeTop:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0078"];
            break;
        case SHLightTypeAtmosphere:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0079"];
            break;
        case SHLightTypeWall:
            [[SHSocket sharedSHSocket] sendSocketUp:@"007A"];
            break;
        case SHLightTypeBar:
            [[SHSocket sharedSHSocket] sendSocketUp:@"007B"];
            break;
        case SHLightTypeRead:
            [[SHSocket sharedSHSocket] sendSocketUp:@"0113"];
            break;

        default:
            break;
    }
}



@end
