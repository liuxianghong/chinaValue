//
//  KspApplyCancelModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   取消竞标


#import <Foundation/Foundation.h>

@interface KspApplyCancelModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *Result;
@property(nonatomic,strong)NSString *Msg;
@end
