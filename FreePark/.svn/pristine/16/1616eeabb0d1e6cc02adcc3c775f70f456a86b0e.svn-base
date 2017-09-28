//
//  HomeVC.m
//  FreePark
//
//  Created by zhangwx on 15/12/12.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "HomeVC.h"
#import "FindParkVC.h"
#import "FindViewController.h"
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD showSuccessWithStatus:@"恭喜!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionGotoFindPark:(id)sender
{
    FindParkVC *findParkVC = [[FindParkVC alloc] initWithNibName:@"FindParkVC" bundle:nil];
    [self.navigationController pushViewController:findParkVC animated:YES];
}
- (IBAction)find:(id)sender {
    FindViewController *find  = [[FindViewController alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}

- (IBAction)actionSharePark:(id)sender {
    
}

@end
