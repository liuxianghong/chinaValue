//
//  CostDetailHeader.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/4.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//costdetail的heanderView

#import "CostDetailHeader.h"


@implementation CostDetailHeader


- (instancetype)init{
    self=[super init];
    if (self) {
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame=self.bounds;
//        button.alpha=0.1;
//        [self addSubview:button];
        
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 64);
//        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(20, 10,100, 20)];
//        name.font=[UIFont systemFontOfSize:15.0f];
//        [self.contentView addSubview:name];
//        self.name=name;
        
        UILabel *date=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 150, 30)];
        date.font=[UIFont systemFontOfSize:15.0f];
        date.textColor=[UIColor grayColor];
        [self.contentView  addSubview:date];
        self.date=date;
        
        UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-160, 20, 100, 30)];// self.frame.size.height-35
        price.font=[UIFont systemFontOfSize:17.0f];
        price.textColor=[UIColor grayColor];
        price.textAlignment=NSTextAlignmentRight;
        [self.contentView  addSubview:price];
        self.price=price;
        
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 27, 17, 15)];
        self.imageView=imageView;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView  addSubview:imageView];
    }
    return self;
}



- (void)initTextWithDic:(NSDictionary *)dic{
    self.name.text=[dic objectForKey:@"name"];
    self.date.text=[dic objectForKey:@"date"];
    self.price.text=[dic objectForKey:@"price"];
    [self.imageView setImage:[UIImage imageNamed:[dic objectForKey:@"image"]]];
   // self.isOpen=NO;//分组默认是关闭的
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
