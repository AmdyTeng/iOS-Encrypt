//
//  CodeTool.m
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//

#import "CodeToolCrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"
#import "NSData+DataToHexStr.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation CodeToolCrypt

//Base64加密  字符串
+(NSString *)encodeBase64:(NSString *)input{
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
//Base64解密  字符串
+(NSString *)decodeBase64:(NSString *)input{
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

//Base64编码，
+(NSString *)base64EncodeString:(NSString *)string
{
    //1.先把字符串转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    //这是苹果已经给我们提供的方法
    NSString *str = [data base64EncodedStringWithOptions:0];
    
    return str;
}

//对base64编码后的字符串进行解码
+(NSString *)base64DecodeString:(NSString *)string
{
    //1.将base64编码后的字符串『解码』为二进制数据
    //这是苹果已经给我们提供的方法
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    //2.把二进制数据转换为字符串返回
    NSString *str =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
}
//Base64 字符串解码成 字符串
+(NSString *)decodeBase64ToHexString:(NSString *)input{
    
    //1.将base64编码后的字符串『解码』为二进制数据
    //这是苹果已经给我们提供的方法
    NSData *myD = [[NSData alloc]initWithBase64EncodedString:input options:0];
    
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
    
}

//MD5加密返回Nsdata
+(NSData *)encodeMD5:(NSData *)input{
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    
    NSData *data =[[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    return data;
}
//MD5加密返回Nsstring
+(NSString *)MD5HexDigest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}


//DES 加密
+(NSData *)encryptUseDES:(NSData *)plainText key:(Byte *)key
{
    NSData *textData = plainText;
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionECBMode,
                                          key, kCCKeySizeDES,
                                          nil,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        return data;
    }
    return nil;
}

//DES 解密
+(NSData *)decrypUseDES:(NSData *)plainText key:(Byte *)key{
    
    NSData *cipherdata = plainText;
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionECBMode,
                                          key, kCCKeySizeDES,
                                          nil,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess)
    {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        return plaindata;
    }
    return nil;
}

//AES 加密
+(NSString *)encrypt:(NSString *)message password:(NSData *)password {
    
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:password error:nil];
    
    NSString * hexString = [encryptedData hexadecimalString];
    
    return hexString;
}
//AES 解密
+(NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password {
    
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

@end
