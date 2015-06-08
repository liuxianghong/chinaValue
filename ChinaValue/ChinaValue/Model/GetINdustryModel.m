//
//  GetINdustryModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "GetINdustryModel.h"

@implementation GetINdustryModel


-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.ID=[dic objectForKey:@"ID"];
        self.Name=[dic objectForKey:@"Name"];
    }
    return  self;
}

@end
