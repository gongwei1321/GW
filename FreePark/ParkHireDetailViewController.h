//
//  ParkHireDetailViewController.h
//  FreePark
//
//  Created by 龚伟 on 2017/8/26.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZParkHire.h"
@interface ParkHireDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *hireTypeLabel;
@property (weak, nonatomic) IBOutlet UITextView *miaosuTextView;
@property(nonatomic,strong) ZZParkHire *zzParkHire;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *miaosuTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *miaosuTextViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *rentTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end
