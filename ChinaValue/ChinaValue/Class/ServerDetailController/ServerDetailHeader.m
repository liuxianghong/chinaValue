//
//  ServerDetailHeader.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//服务详情表的header

#import "ServerDetailHeader.h"

@implementation ServerDetailHeader


-(instancetype)init{
    self=[super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:200.f/255.f green:219.f/255.f blue:215.f/255.f alpha:1]];
        //头像
        self.imageView=[[UIImageView alloc]init];
        self.imageView.frame=CGRectMake(10,2,65, 65);
        [self.contentView addSubview:self.imageView];
        //标题
        self.title=[[UILabel alloc]initWithFrame:CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width+30, 10, 200, 20)];
        [self.title setFont:[UIFont systemFontOfSize:15.0]];
        [self.contentView addSubview:self.title];
        //日期
        self.date=[[UILabel alloc]initWithFrame:CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width+30, 35, 150, 20)];
        [self.date setFont:[UIFont systemFontOfSize:15.0]];
        [self.date setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.date];
        
        self.imageView.layer.cornerRadius = self.imageView.height/2;
        self.imageView.layer.borderWidth = 0;
        self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
        self.imageView.layer.masksToBounds = YES;
        //200,219 ,215
    }
    return self;

}

//填充数据
- (void)loadDataWithDic:(NSDictionary *)dic{
    [self.title setText:[dic objectForKey:@"title"]];
    [self.date setText:[dic objectForKey:@"date"]];
    [self.imageView setImage:[UIImage imageNamed:[dic objectForKey:@"image"]]];
}




@end
