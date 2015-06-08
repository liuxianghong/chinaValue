//
//  TradeLogModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TradeLogModel : NSObject
-(id)initWitDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *DateTime;
@property(nonatomic,strong)NSString *Fee; //费用
@property(nonatomic,strong)NSString *ReqID; //需求id
@property(nonatomic,strong)NSString *ReqTitle;
@property(nonatomic,strong)NSString *Type;
@property(nonatomic,strong)NSString *TypeName;
@property(nonatomic)BOOL extend;
@end
