//
//  KspReqDetailModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspReqDetailModel.h"

@implementation KspReqDetailModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.Step=[dic objectForKey:@"Step"];
        self.Status=[dic objectForKey:@"Status"];
        self.Name=[dic objectForKey:@"Name"];
        self.Desc=[dic objectForKey:@"Desc"];
    }
    return self;
}

@end
