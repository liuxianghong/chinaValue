//
//  KspReportViewModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  查看咨询报告
#import "KspReportViewModel.h"

@implementation KspReportViewModel
-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.Result=[dic objectForKey:@"Result"];
        self.URL=[dic objectForKey:@"URL"];
    }
    return  self;
}

@end
