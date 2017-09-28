//
//  FindViewController.m
//  FreePark
//
//  Created by 龚伟 on 15/12/23.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "FindViewController.h"
#import "ZZRadioButton.h"
@interface FindViewController ()
@property (nonatomic,strong) ZZRadioButton *buttonA;
@property (nonatomic,strong) ZZRadioButton *buttonB;
@property (nonatomic,strong) ZZRadioButton *buttonC;
@property (nonatomic,strong) ZZRadioButton *buttonD;
@property (nonatomic,strong) UIButton *commitButton;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZZColor(88, 195, 218);
    self.title = @"发现";
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"1:每天第一位答对的朋友,获得10元话费奖励.\r\n2:非第一位，但连续三天大队，获10元奖励.\r\n3.格式:“答案、邮箱”,如\"帕萨特\"xxx@qq.com.\r\n11-16答案:柯尼塞格 agera;英雄榜:9008****\r\n时间:11:45!";
//    [label.text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
   label.frame = CGRectMake(16, 80, self.view.frame.size.width - 32, 100);
    label.textColor = [UIColor whiteColor];
    [label setContentMode:UIViewContentModeTop];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    
    //白色底图
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 15.0f;
    view.frame = CGRectMake(16, CGRectGetMaxY(label.frame) + 80, self.view.frame.size.width - 32, 200);
    [self.view addSubview:view];
    
    
    //考考你图片
    UIImage *image = [UIImage imageNamed:@"kaokaoni"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = CGPointMake(view.frame.size.width/2, 40);
    imageView.bounds = CGRectMake(0, 0,image.size.width, image.size.height);
    [view addSubview:imageView];
    
   
    //题目标题
    UILabel *questionTitle = [[UILabel alloc] init];
    questionTitle.text = @"奥迪汽车公司是又几家公司合并而成?";
    questionTitle.textColor = [UIColor grayColor];
    questionTitle.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 8, view.frame.size.width, 50);
    questionTitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:questionTitle];
    
    //中间的线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = ZZColor(224, 225, 225);
    line.frame = CGRectMake(8, CGRectGetMaxY(questionTitle.frame)+8, view.frame.size.width -16, 1);
    [view addSubview:line];
    
    //四个单选
    CGFloat buttonY = CGRectGetMaxY(line.frame) +8;
    self.buttonA = [self setupRadionWithView:view tag:0 buttonY: buttonY];
    [self.buttonA setTitle:@"1234" forState:UIControlStateNormal];
    self.buttonB = [self setupRadionWithView:view tag:1 buttonY: buttonY];
    self.buttonC = [self setupRadionWithView:view tag:2 buttonY: buttonY];
    self.buttonD = [self setupRadionWithView:view tag:3 buttonY: buttonY];
    
    //提交按钮
    UIImage *commitImage = [UIImage imageNamed:@"commit"] ;
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setImage:commitImage forState:UIControlStateNormal];
    [commitButton setImage:[UIImage imageNamed:@"commit_selected"] forState:UIControlStateHighlighted];
    commitButton.center = CGPointMake(self.view.frame.size.width/2, CGRectGetMaxY(view.frame) + 80);
    commitButton.bounds = CGRectMake(0, 0, commitImage.size.width, commitImage.size.height);
    [self.view addSubview:commitButton];
    
                              

    
}

- (ZZRadioButton *)setupRadionWithView:(UIView *)view tag:(NSInteger)tag buttonY:(CGFloat)buttonY
{
    CGFloat buttonW =  (view.frame.size.width - 16)/4;
    CGFloat buttonH =  50;
    ZZRadioButton *button = [ZZRadioButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"radiocheck"] forState:UIControlStateSelected];
    button.frame = CGRectMake(8 + tag*buttonW, buttonY, buttonW, buttonH);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:button];
    return button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
