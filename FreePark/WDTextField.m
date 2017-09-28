//
//  WDTextField.m
//  Wanda
//
//  Created by zhangwx on 15/7/19.
//  Copyright (c) 2015年 万达. All rights reserved.
//

#import "WDTextFieldPrivate.h"

@implementation WDTextField

- (BOOL)becomeFirstResponder
{
    [self addCheck];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    if ([self.wddelegate respondsToSelector:@selector(WDTextFieldEndEdit:)]) {
        [self.wddelegate WDTextFieldEndEdit:self];
    }
    return [super resignFirstResponder];
}

+ (instancetype)textFieldWithType:(WDTextFieldType)type
{
    switch (type) {
        case WDTextFieldName:
            return [[WDTextField_Name alloc] init];
        case WDTextFieldPass:
            return [[WDTextField_Pass alloc] init];
        case WDTextFieldPhoneNumber:
            return [[WDTextField_PhoneNumber alloc] init];
        case WDTextFieldYZM:
            return [[WDTextField_YZM alloc] init];
        case WDTextFieldMail:
            return [[WDTextField_Mail alloc] init];
        case WDTextFieldVerificationCode:
            return [[WDTextField_VerificationCode alloc] init];
        default:
            return nil;
    }
}

- (void)setType:(WDTextFieldType)type
{
    _type = type;
    switch (type) {
        case WDTextFieldName:
            self.checkRule = nil;
            self.minLength = 0;
            self.maxLength = INT32_MAX;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case WDTextFieldPass:
            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$"];
//            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$){6,20}$"];
            self.minLength = 6;
            self.maxLength = INT32_MAX;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case WDTextFieldPhoneNumber:
            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[0-9]{10}"];
            self.maxLength = 11;
            self.minLength = 11;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypePhonePad;
            break;
        case WDTextFieldYZM:
            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]{6}"];
            self.maxLength = 6;
            self.minLength = 6;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case WDTextFieldVerificationCode:
            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(\\d{14}|\\d{17})(\\d|[xX])$"];
            self.maxLength = 18;
            self.minLength = 15;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case WDTextFieldMail:
            self.checkRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
            self.maxLength = INT32_MAX;
            self.minLength = 3;
            self.canBeEmpty = NO;
            self.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        default:
            break;
    }
}

- (void)addCheck
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textChange:(NSNotification *)notify
{
    if(![notify.object isEqual:self])
    {
        return;
    }
    
    UITextField *textField = self;
    
    NSString *toBeString = textField.text;
    //    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    //    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if(!position) {
        int length = [self countWord:toBeString];
        if(length > self.maxLength) {//TODO截取的有问题
            textField.text = [self subStringWithMaxLength:toBeString];
        }
    }
    //有高亮选择的字符串，则暂不对文字进行统计和限制
    else{
        
    }
}

- (int)countWord:(NSString *)s
{
    int i,l=0,a=0,b=0;
    NSInteger n=s.length;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l*2+a+b;
}

- (NSString *)subStringWithMaxLength:(NSString *)sourceStr
{
    NSMutableString *retStr = [[NSMutableString alloc] init];
    int count = 0;
    NSInteger n=sourceStr.length;
    unichar c;
    for(int i=0;i<n;i++){
        c=[sourceStr characterAtIndex:i];
        if(isascii(c)){
            count++;
        }else{
            count = count+2;
        }
        if (count <= self.maxLength) {
            [retStr appendString:[NSString stringWithCharacters:&c length:1]];
        }else{
            break;
        }
    }
    return retStr;
}

- (BOOL)check
{
    if ((self.text.length == 0 && !self.canBeEmpty) || self.text.length < self.minLength || self.text.length > self.maxLength) {
        return NO;
    }
    if (!self.checkRule) {
        return YES;
    }
    return [self.checkRule evaluateWithObject:self.text];
}

@end
