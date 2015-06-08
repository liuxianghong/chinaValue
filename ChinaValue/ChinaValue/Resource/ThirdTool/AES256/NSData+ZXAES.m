//
//  NSData+ZXAES.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/7.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSData+ZXAES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import "GTMBase64.h"
#define TOKEN @"chinavaluetoken=abcdefgh01234567"
@implementation NSData (ZXAES)


///**
// AES加密
// */
//+(NSString *)AES256Encrypt:(NSString *)clearText key:(NSString *)key{
//    NSData *data=[clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    char keyPtr[kCCKeySizeAES256+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    NSUInteger dataLength=[data length];
//    
//    size_t bufferSize=dataLength + kCCBlockSizeAES128;
//    void *buffer=malloc(bufferSize);
//    
//    size_t numBytesEncrypted =0;
//    CCCryptorStatus cryptStatus=CCCrypt(kCCEncrypt,
//                                        kCCAlgorithmAES128,
//                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                        keyPtr,
//                                        kCCKeySizeAES256,
//                                        nil,
//                                        [data bytes],
//                                        [data length],
//                                        buffer,
//                                        bufferSize,
//                                        &numBytesEncrypted);
//    NSString *plainText=nil;
//    if (cryptStatus==kCCSuccess) {
//        
//        NSData *dataTemp=[NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        
//        NSString *addToken=[NSString stringWithFormat:@"%@%@",dataTemp,TOKEN];//拼接TOKEN
//        NSLog(@"拼接token之后：%@",addToken);
//        
//        NSData *addTokenData=[addToken dataUsingEncoding:NSUTF8StringEncoding];//把拼接TOKEN之后的字符串转成Data
//        NSLog(@"拼接token转成Data:%@",addTokenData);
//        
//        plainText=[GTMBase64 stringByEncodingData:addTokenData];//Base64转码
//        
//    }else{
//        NSLog(@"AES加密失败");
//    }
//    
//    return plainText;
//}
//
//
///**
// AES解密
// */
//
//+(NSString *)AES256Decrypt:(NSString *)cipherText key:(NSString *)key{
//    //先用Base64解码传入的cipherText字符串
//    NSData *cipherData=[GTMBase64 decodeString:cipherText];
//    NSLog(@"Base64解密之后的Data：%@",cipherData);
//    
//    //把Base64解密后的data转成String再去掉TOKEN
//    NSString *cipherString=[[NSString alloc]initWithData:cipherData encoding:NSUTF8StringEncoding];//NSASCIIStringEncoding时不为空
//    
//    NSLog(@"Base64解密之后Data转成String:%@",cipherString);
//    
//    //把token去掉
//    NSMutableString *cipherMutable = [NSMutableString stringWithFormat:@"%@",cipherString];
//    NSRange range = [cipherMutable rangeOfString:TOKEN];
//  //  [cipherMutable deleteCharactersInRange:range];
//    
//    
//    //把去掉Token之后的string转成data进行AES解密
//    NSData *cipherMutableData=[cipherMutable dataUsingEncoding:NSUTF8StringEncoding];//对这个AES解密获得Json
//    
//    
//    
//    char keyPtr[kCCKeySizeAES256 +1];
//    bzero(keyPtr, sizeof(keyPtr));
//    
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    NSUInteger dataLength = [cipherMutableData length];
//    
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    
//    size_t numBytesDecrypted = 0;
//    
//    CCCryptorStatus cryptStatus=CCCrypt(kCCDecrypt,
//                                        kCCAlgorithmAES128,
//                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                        keyPtr,
//                                        kCCKeySizeAES256,
//                                        nil,
//                                        [cipherMutableData bytes],
//                                        [cipherMutableData length],
//                                        buffer,
//                                        bufferSize,
//                                        &numBytesDecrypted);
//    NSString *plainText = nil;
//    if (cryptStatus == kCCSuccess) {
//        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//        plainText = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    }else{
//        NSLog(@"AES解密失败");
//    }
//    return plainText;
//}
//
//
//
//
//















/**
 AES加密
 */
+(NSString *)AES256Encrypt:(NSString *)clearText key:(NSString *)key{
    NSData *data=[clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength=[data length];
    
    size_t bufferSize=dataLength + kCCBlockSizeAES128;
    void *buffer=malloc(bufferSize);
    
    size_t numBytesEncrypted =0;
    CCCryptorStatus cryptStatus=CCCrypt(kCCEncrypt,
                                        kCCAlgorithmAES128,
                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
                                        keyPtr,
                                        kCCKeySizeAES256,
                                        nil,
                                        [data bytes],
                                        [data length],
                                        buffer,
                                        bufferSize,
                                        &numBytesEncrypted);
    NSString *plainText=nil;
    if (cryptStatus==kCCSuccess) {
        NSData *dataTemp=[NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText=[GTMBase64 stringByEncodingData:dataTemp];//Base64转码
        
    }else{
        NSLog(@"AES加密失败");
    }
    
    return plainText;
}


/**
    AES解密
 */

+(NSString *)AES256Decrypt:(NSString *)cipherText key:(NSString *)key{
    //先用Base64解码传入的cipherText字符串
    NSData *cipherData=[GTMBase64 decodeString:cipherText];
  //  NSLog(@"cipherData is ********************:%@",cipherData);
    
    
    char keyPtr[kCCKeySizeAES256 +1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus=CCCrypt(kCCDecrypt,
                                        kCCAlgorithmAES128,
                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
                                        keyPtr,
                                        kCCKeySizeAES256,
                                        nil,
                                        [cipherData bytes],
                                        [cipherData length],
                                        buffer,
                                        bufferSize,
                                        &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
       // NSLog(@"cryptStatus***********************************************:%@",data);
        plainText = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] init]; //NSUTF8StringEncoding
       // NSString *dataUTF8 = [plainText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       // NSString *dataGBK = [dataUTF8 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"dataUTF8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:%@",dataGBK);
        
    }else{
        NSLog(@"AES解密失败");
    }
    return plainText;
}


@end
