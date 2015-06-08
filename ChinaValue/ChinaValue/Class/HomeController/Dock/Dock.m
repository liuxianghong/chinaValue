//
//  Dock.m
//  
//
//  Created by Mac on 15-2-7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
#import "NSString+ZX.h"
#import "UIImage+ZX.h"

@interface Dock()
{
    DockItem *_dockItem;
    
   
    
}
@end

@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      //  self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"first_buttom_bg.PNG"]];
       // self.backgroundColor=[UIColor colorWithRed:248 green:248 blue:248 alpha:1];
//        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_buttom_bg.PNG"]];
//        imageView.frame=self.bounds;
//        [self addSubview:imageView];
    }
    return self;
}

- (void)addDockItem:(NSString *)image title:(NSString *)title{
    DockItem *item=[[DockItem alloc]init];
    
    [item setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
  //  [item setImage:[UIImage imageNamed:[image fileAppend:@"_selected"]] forState:UIControlStateSelected];//选中状态
    [item setTitle:title forState:UIControlStateNormal];
    //添加监听
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    //添加item
    [self addSubview:item];
    
    NSInteger count=self.subviews.count;
    //默认要选中第5个item
    if(count==5){
        //相当于默认点击了第5个item
        //[self itemClick:item];
    }
    CGFloat height=self.frame.size.height;
    CGFloat width=self.frame.size.width/count;
    for (NSInteger i=0; i<count; i++) {
        DockItem *dockItem=self.subviews[i];
        dockItem.tag=i;
        dockItem.frame=CGRectMake(i*width, 0, width, height);
       
    }
}

#pragma mark item点击监听
-(void)itemClick:(DockItem *)item{
    //通知代理
    if([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)])
    {
        [_delegate dock:self itemSelectedFrom:_dockItem.tag to:item.tag];
    }
    
//    //取消当前选中
//    _dockItem.selected=NO;
////    //设置选中
//    item.selected=YES;
//    _dockItem=item;
//    if (item.enabled) {
//        item.enabled=NO;
//    }
    
    
}



@end
