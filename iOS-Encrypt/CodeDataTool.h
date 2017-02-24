//
//  CodeDataTool.h
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//Byte  Hex  Nsdata NSString  互相转换

#import <Foundation/Foundation.h>

@interface CodeDataTool : NSObject

/**
 数字字符串 转 ASCII 码
 */
+(int )getAscIIWithString:(NSString *)numStr;

/**
 Byte数组 转为 Nsdata
 */
+(NSData *)ByteToNsdataWith:(Byte *)byte;
/**
 Byte数组转为 hex 字符串
 @param byteArray byte数组
 @param space 是否添加空格空格
 @return hex字符串
 */
+(NSString *)BytesToHexString:(Byte *)byteArray isSpace:(BOOL)space;

/**
 十六进制字符串转Data
 */
+(NSData *)HexStrToData:(NSString *)hex;

/**
 传入 data 返回 16进制 字符串 ，是否有空格
 */
+(NSString *)dataToHexString:(NSData *)data isSpace:(BOOL)space;

/**
 普通字符串转换为十六进制
 */
+(NSString *)StringToHexString:(NSString *)string;

/**
 十六进制转换为普通字符串
 */
+(NSString *)HexSrtingToString:(NSString *)hexString;

/**
 根据传入的16进制data 转化成 10进制字符串
 */
+(NSString *)getTenStringWithData:(NSData *)inputData;

/**
 传入的16进制data，Base64编码后，再返回16进制的Nsdata
 */
+(NSData *)getHexDataAfterBase64EncodeWithHexData:(NSData *)inputData;

/*
 传入的16进制data，Base64解码后，再返回16进制的Nsdata
 */
+(NSData *)getHexDataAfterBase64DecodeWithHexData:(NSData *)inputData;

@end
