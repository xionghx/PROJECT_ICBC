//
//  XStringUtils.m
//  童伙妈妈
//
//  Created by LuSW on 16/7/4.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "XStringUtils.h"
#import <CommonCrypto/CommonDigest.h>


@implementation XStringUtils : NSObject

+ (NSString *)jsonStringWithParameters:(id)parameters {
    if (parameters == nil) {
        return @"";
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


+ (BOOL)isTextEmpty:(NSString *)string {
    if (string == nil || (id)string == [NSNull null]) {
        return YES;
    }else{
        if (![string respondsToSelector:@selector(length)]) {
            return YES;
        }
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([string length]) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)md5HexDigestWithString:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)str.length, digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}









@end
