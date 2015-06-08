//
//  GetKspListModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/14.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  查找服务方
#import <Foundation/Foundation.h>

@interface GetKspListModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *Sex;
@property(nonatomic,strong)NSString *CompanyName;
@property(nonatomic,strong)NSString *DutyName;
@property(nonatomic,strong)NSString *About;
@property(nonatomic,strong)NSString *Avatar;

@end
