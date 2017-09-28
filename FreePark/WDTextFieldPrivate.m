//
//  WDTextFieldPrivate.m
//  Wanda
//
//  Created by zhangwx on 15/7/19.
//  Copyright (c) 2015年 万达. All rights reserved.
//

#import "WDTextFieldPrivate.h"

@implementation WDTextField_YZM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]{6}"];
        self.maxLength = 6;
        self.minLength = 6;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

@end

@implementation WDTextField_Pass

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$"];
        self.minLength = 6;
        self.maxLength = INT32_MAX;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

@end

@implementation WDTextField_PhoneNumber

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[0-9]{10}"];
        self.maxLength = 11;
        self.minLength = 11;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypePhonePad;
    }
    return self;
}

@end

@implementation WDTextField_Mail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
        self.maxLength = INT32_MAX;
        self.minLength = 3;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return self;
}

@end

@implementation WDTextField_VerificationCode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(\\d{14}|\\d{17})(\\d|[xX])$"];
        self.maxLength = 18;
        self.minLength = 15;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

@end

@implementation WDTextField_Name

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.checkRule = nil;
        self.minLength = 0;
        self.maxLength = INT32_MAX;
        self.canBeEmpty = NO;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

@end