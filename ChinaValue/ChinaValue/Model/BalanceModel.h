//
//  BalanceModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceModel : NSObject

-(id)initBalanceWithDic:(NSDictionary *)dic;

//账户余额
@property(nonatomic,strong)NSString *balance;
@end
