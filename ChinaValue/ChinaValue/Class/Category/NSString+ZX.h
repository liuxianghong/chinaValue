//
//  NSString+ZX.h
//  我的新浪微博
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NoNillString(a) a?a:@""
@interface NSString (ZX)

-(NSString *)fileAppend:(NSString *)append;

- (NSString *)removeHTML;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
@end
