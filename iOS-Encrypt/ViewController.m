//
//  ViewController.m
//  iOS-Encrypt
//
//  Created by Amdyteng的Mac on 2017/2/23.
//  Copyright © 2017年 Amdyteng的Mac. All rights reserved.
//

#import "ViewController.h"
#import "CodeToolCrypt.h"
#import "CodeDataTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Base64 解码 成 16进制 字符串
    NSString *hexStr = [CodeToolCrypt decodeBase64ToHexString:@"//////////8="];
    NSLog(@"Base64 解码 成 16进制 字符串%@",hexStr);
    //Base64 加密 字符串
    NSString *Base64Str1 = [CodeToolCrypt encodeBase64:@"12345"];
    NSLog(@"第一种加密：%@",Base64Str1);
    
    NSString *Base64Str2 = [CodeToolCrypt base64EncodeString:@"12345"];
    NSLog(@"第二种加密：%@",Base64Str2);
    
    //Base64 解密  字符串
    NSString *deBase64Str1 = [CodeToolCrypt decodeBase64:@"MTIzNDU="];
    NSLog(@"第一中解密%@",deBase64Str1);
    NSString *deBase64Str2 = [CodeToolCrypt base64DecodeString:@"MTIzNDU="];
    NSLog(@"第二中解密%@",deBase64Str2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
