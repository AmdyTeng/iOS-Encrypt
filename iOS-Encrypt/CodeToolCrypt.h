//
//  CodeTool.h
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface CodeToolCrypt : NSObject
/**
 Base64 加密
 */
+(NSString *)encodeBase64:(NSString *)input;
/**
 Base64 加密
 */
+(NSString *)base64EncodeString:(NSString *)string;

/*
 Base 64 解密
 */
+(NSString *)decodeBase64:(NSString *)input;
/*
 Base 64 解密
 */
+(NSString *)base64DecodeString:(NSString *)string;
/**
 Bsse64 解码 成 16进制字符串样式
 */
+(NSString *)decodeBase64ToHexString:(NSString *)input;

/*
 MD5加密 返回data
 */
+(NSData *)encodeMD5:(NSData *)input;
/*
 MD5加密 返回 string
 */
+(NSString *)MD5HexDigest:(NSData *)input;
/**
 DES加密
 */
+(NSData *)encryptUseDES:(NSData *)plainText key:(Byte *)key;
/**
 DES解密
 */
+(NSData *)decrypUseDES:(NSData *)plainText key:(Byte *)key;
/*
 AES加密
 */
+ (NSString *)encrypt:(NSString *)message password:(NSData *)password;
/**
 AES解密
 */
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;


@end
