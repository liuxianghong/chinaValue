//
//  DemandDetailHeader.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/17.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "DemandDetailHeader.h"

@implementation DemandDetailHeader

-(instancetype)init{
    self=[super init];
    if (self) {
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 125);
        //头像和name后面的背景view
        CGFloat height=self.frame.size.height/2+5;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,height)];
        view.frame=CGRectMake(0,0, self.frame.size.width, self.frame.size.height-60);
        [view setBackgroundColor:[UIColor whiteColor]];
        
        //头像
        UIImageView *headeView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 5,55, 55)];
        
        [view addSubview:headeView];
        self.headerView=headeView;
        
        //name
        UILabel *name=[[UILabel alloc]init];
        name.frame=CGRectMake(80, 25, 100, 20);
        [name setFont:[UIFont systemFontOfSize:15.0f]];
        [view addSubview:name];
        self.name=name;
        
        [self.contentView addSubview:view];
        
        
        //button邀请竞标
//        UIButton *askedbiddButton=[UIButton buttonWithType:UIButtonTypeCustom];//40
        CGFloat width=(self.frame.size.width-40)/3;
        CGFloat Y=self.frame.size.height-height;
        CGFloat H=Y-20;
//        askedbiddButton.frame=CGRectMake(15, Y+20, width, H);
//        [askedbiddButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
//        [askedbiddButton setTitle:@"邀请竞标" forState:UIControlStateNormal];
//        [askedbiddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [askedbiddButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//        [self.contentView addSubview:askedbiddButton];
//
        //
        UIButton *relationButton1=[UIButton buttonWithType:UIButtonTypeCustom];
        relationButton1.frame=CGRectMake(10, Y+20, width, H);
        [relationButton1 setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [relationButton1 setTitle:@"竞标" forState:UIControlStateNormal];
        [relationButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [relationButton1.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview: relationButton1];
        self.btn1 = relationButton1;
        
        //我和他的关系
        UIButton *relationButton=[UIButton buttonWithType:UIButtonTypeCustom];
        relationButton.frame=CGRectMake(20+width, Y+20, width, H);
        [relationButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [relationButton setTitle:@"我和他的关系" forState:UIControlStateNormal];
        [relationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [relationButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview: relationButton];
        self.btn2 = relationButton;
        
        //查看信用评价
        UIButton *checkCreditButton=[UIButton buttonWithType:UIButtonTypeCustom];
        checkCreditButton.frame=CGRectMake(width+width+30, Y+20, width, H);
        [checkCreditButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [checkCreditButton setTitle:@"查看信用评价" forState:UIControlStateNormal];
        [checkCreditButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [checkCreditButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview:checkCreditButton];
        self.btn3 =checkCreditButton;
        
    }
    return self;
}


@end
