//
//  UIBarButtonItem+ZX.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UIBarButtonItem+ZX.h"

@implementation UIBarButtonItem (ZX)
- (id)initWithIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action{
    UIImage *image=[UIImage imageNamed:icon];
    UIButton *button=[[UIButton alloc]init];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //设置尺寸
    //button.bounds=(CGRect){CGPointZero,image.size};
    //    button.frame=CGRectMake(0, 0, 15, 30);
    button.bounds=CGRectMake(0, 0, 18, 25);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}

- (id)initWithRightIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action{
    UIImage *image=[UIImage imageNamed:icon];
    UIButton *button=[[UIButton alloc]init];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //设置尺寸
    //button.bounds=(CGRect){CGPointZero,image.size};
    //    button.frame=CGRectMake(0, 0, 15, 30);
    button.bounds=CGRectMake(0, 0, 30, 30);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}

- (id)initWithLeftIcon:(NSString *)icon highLight:(NSString *)hightImage target:(id)target action:(SEL)action{
    UIImage *image=[UIImage imageNamed:icon];
    UIButton *button=[[UIButton alloc]init];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //设置尺寸
    //button.bounds=(CGRect){CGPointZero,image.size};
    //    button.frame=CGRectMake(0, 0, 15, 30);
    button.bounds=CGRectMake(0, 0, 35, 20);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}

-(id)initWithText:(NSString *)text target:(id)target action:(SEL)action{
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button.bounds=CGRectMake(0, 0, 60, 20);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}


@end
