//
//  UserInformationView.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/3.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetKspListModel.h"
@interface UserInformationView : UIView
-(void)initTextWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *serverPrice;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UILabel *comentPeople;
@property(nonatomic,strong)UILabel *publisherName;


//标签
@property(nonatomic,strong)UILabel *label1;//服务费用
@property(nonatomic,strong)UILabel *label2;//地点
@property(nonatomic,strong)UILabel *label3; //当前人数
@property(nonatomic,strong)UILabel *label4;  //发布人



@end
