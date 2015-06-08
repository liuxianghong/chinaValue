//
//  TradeLogModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  收入支出明细

#import "TradeLogModel.h"

@implementation TradeLogModel
-(id)initWitDic:(NSDictionary *)dic{
    self=[super init];
    self.DateTime=[dic objectForKey:@"DateTime"];
    self.Fee=[dic objectForKey:@"Fee"];
    self.ReqID=[dic objectForKey:@"ReqID"];
    self.ReqTitle=[dic objectForKey:@"ReqTitle"];
    self.Type=[dic objectForKey:@"Type"];
    self.TypeName=[dic objectForKey:@"TypeName"];
    _extend = NO;
    return self;
}
@end
