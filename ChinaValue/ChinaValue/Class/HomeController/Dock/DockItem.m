//
//  DockItem.m
//  
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "DockItem.h"

//item底部文字的高度
#define kTitleHeight 0.3
@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //文字居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        //文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:13];
        
            //选中时的背景
       // [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:10.0];
        
      
        
    }
    return self;
}
#pragma mark 覆盖父类在heighLight时的所有方法
- (void)setHighlighted:(BOOL)highlighted{
    
}

#pragma mark 调整imageview内部的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW=25;
    CGFloat imageH=25;
    CGFloat imageX=24;
    CGFloat imageY=10;
    contentRect=CGRectMake(imageX, imageY, imageW, imageH);
    return contentRect;
}


#pragma mark 调整uilabel内部的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat height=contentRect.size.height;
    CGFloat titleY=height-height*kTitleHeight;
    CGFloat titleHeight=height*kTitleHeight;
    CGFloat width=contentRect.size.width;
    
    return  CGRectMake(0, titleY, width, titleHeight);
    
}


@end
