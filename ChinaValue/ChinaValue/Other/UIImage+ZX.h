//
//  UIImage+ZX.h
//  我的新浪微博
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZX)

//屏幕适配
+(UIImage *)fullScreenAdapted:(NSString *)string;


//设置图片不被拉伸
+(UIImage *)resiedImage:(NSString *)image;
@end
