//
//  MeZanOrPLViewController.h
//  FreePark
//
//  Created by 龚伟 on 16/4/24.
//  Copyright © 2016年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeZanOrPLViewController : UIViewController
@property(nonatomic,assign) int requestType; //0:分享 1:点评
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
@end
