//
//  WDTextField.h
//  Wanda
//
//  Created by zhangwx on 15/7/19.
//  Copyright (c) 2015年 万达. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDTextField;
@protocol WDTextFieldDelegate <NSObject>

- (void)WDTextFieldEndEdit:(WDTextField *)textField;

@end

typedef NS_ENUM(NSInteger, WDTextFieldType) {
    WDTextFieldYZM = 0,
    WDTextFieldPass,
    WDTextFieldPhoneNumber,
    WDTextFieldName,
    WDTextFieldVerificationCode,//身份证
    WDTextFieldMail
};

@interface WDTextField : UITextField

@property (nonatomic, strong) NSPredicate *checkRule;
@property (nonatomic) NSInteger maxLength;
@property (nonatomic) NSInteger minLength;
@property (nonatomic) BOOL canBeEmpty;
@property (nonatomic, weak) id<WDTextFieldDelegate> wddelegate;
@property (nonatomic) IBInspectable WDTextFieldType type;

- (BOOL)check;

+ (instancetype)textFieldWithType:(WDTextFieldType)type;

@end
