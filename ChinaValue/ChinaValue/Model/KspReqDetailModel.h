//
//  KspReqDetailModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

//  服务管理里面的查看详情

#import <Foundation/Foundation.h>

@interface KspReqDetailModel : NSObject

-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *Step;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Desc;


@end
