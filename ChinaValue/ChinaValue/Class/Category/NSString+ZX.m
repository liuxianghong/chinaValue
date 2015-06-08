//
//  NSString+ZX.m
//  我的新浪微博
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "NSString+ZX.h"

@implementation NSString (ZX)
- (NSString *)fileAppend:(NSString *)append{
    
    //获得文件的扩展名
    NSString *extension=[self pathExtension];
    
    //去除文件的扩展名
    NSString *string=[self stringByDeletingPathExtension];
    
    string=[string stringByAppendingString:append];
    
   return [string stringByAppendingPathExtension:extension];
    
}

- (NSString *)removeHTML{//:(NSString *)html
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    
    NSString *pString = nil;
    theScanner = [NSScanner scannerWithString:self];
    
    
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        pString = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
        
        
    }
    return pString;
    
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}
@end
