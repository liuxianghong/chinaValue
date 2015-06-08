//
//  UIBarButtonItem+ZX.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZX)
//尺寸更小
-(id)initWithIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action;
//尺寸更大
-(id)initWithLeftIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action;
-(id)initWithRightIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action;

//设置问题
-(id)initWithText:(NSString *)text target:(id)target action:(SEL)action;

@end
