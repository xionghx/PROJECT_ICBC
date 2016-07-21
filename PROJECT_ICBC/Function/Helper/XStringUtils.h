//
//  XStringUtils.h
//  童伙妈妈
//
//  Created by LuSW on 16/7/4.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XStringUtils : NSObject

/**
 *  转为JSON字符串
 *
 *  @param parameters 参数
 *
 *  @return JSON字符串
 */
+ (NSString *)jsonStringWithParameters:(id)parameters;


/**
 *  判断字符串是否为空
 *
 *  @param str 参数
 *
 *  @return 判断结果
 */
+ (BOOL)isTextEmpty:(NSString *)string;

/**
 *  MD5加密
 *
 *  @param str 参数
 *
 *  @return 加密后字符串
 */
+ (NSString *)md5HexDigestWithString:(NSString *)str;

@end
