//
//  SercerDemandButon.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/27.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//需求管理中填写服务需求时需求内容的两个button（文字在左边，图片在右边）

#import "SercerDemandButon.h"

@implementation SercerDemandButon

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.titleLabel.font=[UIFont systemFontOfSize:13.0f];
        //  self.imageView.contentMode=UIViewContentModeRight;
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted{
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW=contentRect.size.width;//-(self.frame.size.width-100);
    CGFloat titleH=contentRect.size.height;
    CGFloat titleX=10;
    CGFloat titleY=0;
    contentRect=(CGRect){{titleX,titleY},{titleW,titleH}};
    return contentRect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW=15;//25;
    CGFloat imageH=8;//40;
    CGFloat imageX=contentRect.size.width-50;
    CGFloat imageY=self.frame.size.height/2-2;
    
    // contentRect=(CGRect){{imageX,imageY},{imageW,imageH}};
    contentRect=CGRectMake(imageX, imageY, imageW, imageH);
    return  contentRect;
    
}


@end
