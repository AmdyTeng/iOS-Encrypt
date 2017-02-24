//
//  NSData+DataToHexStr.m
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//

#import "NSData+DataToHexStr.h"

@implementation NSData (DataToHexStr)

- (NSString *)hexadecimalString
{
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer)
    {
        return [NSString string];
    }
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }
    
    return [NSString stringWithString:hexString];
}


@end
