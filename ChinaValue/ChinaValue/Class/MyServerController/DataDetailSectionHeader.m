//
//  DataDetailSectionHeader.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/13.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "DataDetailSectionHeader.h"

@implementation DataDetailSectionHeader

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
        UIButton *askedbiddButton=[UIButton buttonWithType:UIButtonTypeCustom];//40
        self.btn1 = askedbiddButton;
        CGFloat width=(self.frame.size.width-40)/3;
        CGFloat Y=self.frame.size.height-height;
        CGFloat H=Y-20;
        askedbiddButton.frame=CGRectMake(15, Y+20, width, H);
        [askedbiddButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [askedbiddButton setTitle:@"邀请竞标" forState:UIControlStateNormal];
        [askedbiddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [askedbiddButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview:askedbiddButton];
        
        //我和他的关系
        UIButton *relationButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2 = relationButton;
        relationButton.frame=CGRectMake(width+20, Y+20, width, H);
        [relationButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [relationButton setTitle:@"我和他的关系" forState:UIControlStateNormal];
        [relationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [relationButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview: relationButton];
        
        
        //查看信用评价
        UIButton *checkCreditButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn3 = checkCreditButton;
        checkCreditButton.frame=CGRectMake(width*2+25, Y+20, width, H);
        [checkCreditButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
        [checkCreditButton setTitle:@"查看信用评价" forState:UIControlStateNormal];
        [checkCreditButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [checkCreditButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview:checkCreditButton];
        

    }
    return self;
}




@end
