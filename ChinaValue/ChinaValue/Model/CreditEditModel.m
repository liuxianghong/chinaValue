//
//  CreditEditModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   用户评价
#import "CreditEditModel.h"

@implementation CreditEditModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.Result=[dic objectForKey:@"Result"];
    }
    return self;
}

@end
