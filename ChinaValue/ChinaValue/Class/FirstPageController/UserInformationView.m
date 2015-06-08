//
//  UserInformationView.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/3.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UserInformationView.h"
#import "UIImage+ZX.h"
#import "UIImageView+WebCache.h"

@implementation UserInformationView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_bg.png"]];
    bgView.frame=self.bounds;
    bgView.alpha=0.9f;
    [self addSubview:bgView];
    if (self) {
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15,10,self.frame.size.height-20,self.frame.size.height-20)];
        self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
        self.imageView.layer.borderWidth = 0;
        self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
        self.imageView.layer.masksToBounds = YES;
        
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height,10,200,20)];
        [self.name setTextColor:[UIColor whiteColor]];
        [self.name setFont:[UIFont systemFontOfSize:13]];
        [self.name setText:@"hell0"];
        
        
        self.label1=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height,self.name.frame.origin.y+24,80, 10)];
        [self.label1 setText:@"服务费用:"];
        [self.label1 setFont:[UIFont systemFontOfSize:11.0f]];
        [self.label1 setTextColor:[UIColor whiteColor]];
        
        
        
        
        self.serverPrice=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height+80+5, self.name.frame.origin.y+24, 80, 10)];
         [self.serverPrice setTextColor:[UIColor whiteColor]];
        [self.serverPrice setFont:[UIFont systemFontOfSize:11.0f]];
        [self.serverPrice setText:@"1元"];
        
        
        
        self.label2=[[UILabel alloc]initWithFrame:CGRectMake(self.serverPrice.frame.origin.x+self.serverPrice.frame.size.width+5, self.name.frame.origin.y+24, 80, 10)];
        [self.label2 setText:@"服务地点:"];
        [self.label2 setFont:[UIFont systemFontOfSize:11.0f]];
        [self.label2 sizeToFit];
        self.label2.frame = CGRectMake(self.serverPrice.frame.origin.x+self.serverPrice.frame.size.width+5, self.name.frame.origin.y+24, self.label2.frame.size.width, 10);
         [self.label2 setTextColor:[UIColor whiteColor]];
        
        
        
        
        
        
        self.address=[[UILabel alloc]initWithFrame:CGRectMake(self.label2.frame.origin.x+self.label2.frame.size.width+10,self.name.frame.origin.y+24, 40, 10)];
         [self.address setTextColor:[UIColor whiteColor]];
        [self.address setFont:[UIFont systemFontOfSize:11.0f]];
        [self.address setText:@"china"];
        
        
        
        
        
        
        self.label3=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height,self.serverPrice.frame.origin.y+24, 80, 10)];
        [self.label3 setText:@"当前竞标人数:"];
         [self.label3 setTextColor:[UIColor whiteColor]];
        [self.label3 setFont:[UIFont systemFontOfSize:11.0f]];
        
        
        
        
        self.comentPeople=[[UILabel alloc]initWithFrame:CGRectMake(self.label3.frame.origin.x+80+5, self.serverPrice.frame.origin.y+24, 80, 10)];
        [self.comentPeople setTextColor:[UIColor whiteColor]];
        [self.comentPeople setFont:[UIFont systemFontOfSize:11.0f]];
        
        
        
        
        self.label4=[[UILabel alloc]initWithFrame:CGRectMake(self.label2.frame.origin.x,self.comentPeople.frame.origin.y+6, 80, 10)];
        [self.label4 setTextColor:[UIColor whiteColor]];
        [self.label4 setFont:[UIFont systemFontOfSize:11.0f]];
        [self.label4 setText:@"发布人:"];
        
        
        
        self.publisherName=[[UILabel alloc]initWithFrame:CGRectMake(self.label4.frame.origin.x+60,self.comentPeople.frame.origin.y+6, 40, 10)];
         [self.publisherName setTextColor:[UIColor whiteColor]];
        [self.publisherName setFont:[UIFont systemFontOfSize:11.0f]];
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.name];
        [self addSubview:self.label1];
        [self addSubview:self.serverPrice];
        [self addSubview:self.label2];
        [self addSubview:self.address];
        [self addSubview:self.label3];
        [self addSubview:self.comentPeople];
        [self addSubview:self.label4];
        [self addSubview:self.publisherName];
         
    }
  
    return self;
    
}

-(void)initTextWithDic:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    [self.imageView sd_setImageWithURL:dic[@"PublisherAvatar"]];
    self.name.text=[dic objectForKey:@"Title"];
    self.serverPrice.text=[dic objectForKey:@"Price"];
    self.address.text=[dic objectForKey:@"ReqCity"];
    self.comentPeople.text=[dic objectForKey:@"Competitors"];
    self.publisherName.text=[dic objectForKey:@"PublisherName"];
}

@end
