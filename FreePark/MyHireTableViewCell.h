//
//  MyHireTableViewCell.h
//  FreePark
//
//  Created by 龚伟 on 2017/8/19.
//  Copyright © 2017年 zhangwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyHireTableViewCellelegate <NSObject>
- (void)detailHire:(NSInteger )index;
- (void)modifiyHire:(NSInteger )index;
- (void)deleteHire:(NSInteger )index;
@end
@interface MyHireTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabe;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *hireTypeLabel;
@property (weak, nonatomic) IBOutlet UITextView *beizhuLabel;

@property (assign, nonatomic) id<MyHireTableViewCellelegate> delegate;
@end
