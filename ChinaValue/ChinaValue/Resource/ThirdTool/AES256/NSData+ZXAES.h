//
//  NSData+ZXAES.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/7.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZXAES)
+(NSString *)AES256Encrypt:(NSString *)clearText key:(NSString *)key;
+(NSString *)AES256Decrypt:(NSString *)cipherText key:(NSString *)key;
@end
