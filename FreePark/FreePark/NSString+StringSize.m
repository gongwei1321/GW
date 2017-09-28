//
//  NSString+StringSize.m
//  XYZ_iOS
//
//  Created by zhangwenxin on 2/18/14.
//  Copyright (c) 2014 焦点科技. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

- (CGSize)stringSizeConstrainedToSize:(CGSize)size WithFont:(UIFont *)font
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    else
    {
        return [self sizeWithFont:font constrainedToSize:size];
    }
}

- (CGSize)stringSizeConstrainedToSize:(CGSize)size WithFont:(UIFont *)font WithAttributes:(NSDictionary *)attributes
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:attributes];
        [dic addEntriesFromDictionary:@{NSFontAttributeName:font}];
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    else
    {
        return [self sizeWithFont:font constrainedToSize:size];
    }
}

@end
