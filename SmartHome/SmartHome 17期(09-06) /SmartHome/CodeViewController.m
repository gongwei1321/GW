//
//  CodeViewController.m
//  SmartHome
//
//  Created by 龚伟 on 2016/11/17.
//  Copyright © 2016年 龚伟. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeImage"]];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width * 0.9, self.view.frame.size.width * 0.9);
    
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view removeFromSuperview];
    
}


@end
