//
//  ParkCommonCell.h
//  FreePark
//
//  Created by zhangwx on 15/12/30.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonWithMenu;

@interface ParkCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commonTitle;
@property (weak, nonatomic) IBOutlet UILabel *commonDetail;
@property (weak, nonatomic) IBOutlet ButtonWithMenu *openButton;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@interface ButtonWithMenu : UIButton

@end
