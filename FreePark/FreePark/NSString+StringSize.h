//
//  NSString+StringSize.h
//  XYZ_iOS
//
//  Created by zhangwenxin on 2/18/14.
//  Copyright (c) 2014 焦点科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

- (CGSize)stringSizeConstrainedToSize:(CGSize)size WithFont:(UIFont *)font;
- (CGSize)stringSizeConstrainedToSize:(CGSize)size WithFont:(UIFont *)font WithAttributes:(NSDictionary *)attributes;

@end