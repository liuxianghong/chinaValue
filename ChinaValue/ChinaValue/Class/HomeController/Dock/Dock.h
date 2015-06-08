//
//  Dock.h
//  
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dock;
//定义一个协议
@protocol DockDelegate <NSObject>

@optional
-(void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to;

@end

@interface Dock : UIView

-(void)addDockItem:(NSString *)image title:(NSString *)title;

// 定义协议代理方法
@property(assign,nonatomic)id<DockDelegate> delegate;

@end
