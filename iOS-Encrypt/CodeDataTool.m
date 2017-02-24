//
//  CodeDataTool.m
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//

#import "CodeDataTool.h"

@implementation CodeDataTool

//数字转 ASCII 码
+(int )getAscIIWithString:(NSString *)numStr{
    
    int asciiCode = [numStr characterAtIndex:0];
    
    return asciiCode;
}

//Byte -> Nsdata
+(NSData *)ByteToNsdataWith:(Byte *)bytes{
    
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    return data;
}

//byte数组转为 hex 字符串
+(NSString *)BytesToHexString:(Byte *)byteArray isSpace:(BOOL)space{
    
    NSString *hexStr=@"";
    for(int i=0;i<sizeof(byteArray);i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",byteArray[i]&0xff]; ///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@ ",hexStr,newHexStr];
            if (space) {
                hexStr = [hexStr stringByAppendingString:@" "];
            }
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@ ",hexStr,newHexStr];
            if (space) {
                hexStr = [hexStr stringByAppendingString:@" "];
            }
        }
    }
    return hexStr;
}

//16进制字符串转为data
+(NSData *)HexStrToData:(NSString *)hex
{
    char buf[3];
    buf[2] = '\0';
    NSAssert(0 == [hex length] % 2, @"Hex strings should have an even number of digits (%@)", hex);
    unsigned char *bytes = malloc([hex length]/2);
    unsigned char *bp = bytes;
    for (CFIndex i = 0; i < [hex length]; i += 2) {
        buf[0] = [hex characterAtIndex:i];
        buf[1] = [hex characterAtIndex:i+1];
        char *b2 = NULL;
        *bp++ = strtol(buf, &b2, 16);
        NSAssert(b2 == buf + 2, @"String should be all hex digits: %@ (bad digit around %ld)", hex, i);
    }
    
    return [NSData dataWithBytesNoCopy:bytes length:[hex length]/2 freeWhenDone:YES];
}


//data 转为 hex 字符串
+(NSString *)dataToHexString:(NSData *)data isSpace:(BOOL)space{
    
    Byte *byteArray = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",byteArray[i]&0xff]; ///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            if (space) {
                hexStr = [hexStr stringByAppendingString:@" "];
            }
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            if (space) {
                hexStr = [hexStr stringByAppendingString:@" "];
            }
        }
    }
    return hexStr;
}
//普通字符串转换为十六进制的
+(NSString *)StringToHexString:(NSString *)string{
    
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
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
    NSLog(@"-----16进制----%@",hexStr);
    return hexStr;
}
// 十六进制转换为普通字符串的
+(NSString *)HexSrtingToString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}

//根据传入的16进制data 转化成 10进制
+(NSString *)getTenStringWithData:(NSData *)inputData{
    
    //先把data转化为16进制字符串
    NSString *hexStr = [self dataToHexString:inputData isSpace:NO];
    
    NSMutableString *mHexStr = [[NSMutableString alloc]initWithString:hexStr];
    //定义一个可变的字符串
    NSMutableString *string = [NSMutableString string];
    if (hexStr.length >=2) {
        for (int i=0; i<hexStr.length/2; i++) {
            
            NSRange range = NSMakeRange(i*2, 2);
            NSString *subStr = [mHexStr substringWithRange:range];
            NSScanner* pScanner = [NSScanner scannerWithString:subStr];
            
            unsigned int iValue;
            [pScanner scanHexInt: &iValue];
            NSString *ascII = [NSString stringWithFormat:@"%d",iValue];
            [string appendString:ascII];
            
        }
    }
    return string;
}

//传入的16进制data，Base64编码后，再返回16进制的Nsdata
+(NSData *)getHexDataAfterBase64EncodeWithHexData:(NSData *)inputData{
    
    NSString *str = [inputData base64EncodedStringWithOptions:0];
    NSString *hexStr = [self StringToHexString:str];
    NSData *msgData = [self HexStrToData:hexStr];
    return msgData;
    
}
//传入的16进制data，Base64解码后，再返回16进制的Nsdata
+(NSData *)getHexDataAfterBase64DecodeWithHexData:(NSData *)inputData{
    
    NSString *hexStr = [NSString stringWithUTF8String:[inputData bytes]];
    
    NSData *hexData = [[NSData alloc]initWithBase64EncodedString:hexStr options:0];
    
    return hexData;
    
}

@end
