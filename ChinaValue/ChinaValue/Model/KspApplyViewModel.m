//
//  KspApplyViewModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//查看竞标详情

#import "KspApplyViewModel.h"

@implementation KspApplyViewModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        
        self.AddTime=[dic objectForKey:@"AddTime"];
        self.Reason=[dic objectForKey:@"Reason"];
        self.Duration=[dic objectForKey:@"Duration"];
        self.Price=[dic objectForKey:@"Price"];
        self.LocationID=[dic objectForKey:@"LocationID"];
        self.Country=[dic objectForKey:@"Country"];
        self.Province=[dic objectForKey:@"Province"];
        self.City=[dic objectForKey:@"City"];
        
    }
    
    return self;
}

@end
