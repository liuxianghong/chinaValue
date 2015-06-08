//
//  MyServerCell.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/30.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServerCell : UITableViewCell
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;
//服务费用
@property (weak, nonatomic) IBOutlet UILabel *price;
//服务地点
@property (weak, nonatomic) IBOutlet UILabel *address;
//当前竞标人数
@property (weak, nonatomic) IBOutlet UILabel *countPeople;
//发布人
@property (weak, nonatomic) IBOutlet UILabel *publisher;
@end
