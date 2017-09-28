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
@property (weak, nonatomic) IBOutlet UILabel *publicTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *hireTypeLabel;
@property (weak, nonatomic) IBOutlet UITextView *miaosuTextView;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property(nonatomic,strong) ZZParkHire *zzParkHire;
@property (weak, nonatomic) IBOutlet UILabel *beginTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *miaosuTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *miaosuTextViewConstraint;
@end
