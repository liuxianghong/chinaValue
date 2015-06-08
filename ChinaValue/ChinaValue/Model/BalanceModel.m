//
//  BalanceModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "BalanceModel.h"

@implementation BalanceModel
-(id)initBalanceWithDic:(NSDictionary *)dic{
    self=[super init];
    
    self.balance=[dic objectForKey:@"Balance"];
    
    
    return self;
}

@end
