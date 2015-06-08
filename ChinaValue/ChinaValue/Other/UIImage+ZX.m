//
//  UIImage+ZX.m
//  我的新浪微博
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "UIImage+ZX.h"
#import "NSString+ZX.h"

@implementation UIImage (ZX)
+ (UIImage *)fullScreenAdapted:(NSString *)string{
   
    
//    //拼接字符串,如果是iphone特殊处理
//    if (iPhone5) {
//        
//        string=[string fileAppend:@"-568h@2x"];
//        
//    }
    return [UIImage imageNamed:string];
}

#pragma mark 图片不被拉伸
+ (UIImage *)resiedImage:(NSString *)imagePath{
    
    UIImage *image=[UIImage imageNamed:imagePath];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];//设置不被拉伸的区域(拉伸的区域在中间一点点
    
}
@end
