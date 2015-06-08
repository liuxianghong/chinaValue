//
//  KspReqListModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
// 服务方管理之竞标列表

#import <Foundation/Foundation.h>

@interface KspReqListModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *ReqID;
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *EndTime;
@property(nonatomic,strong)NSString *Status;

@end
