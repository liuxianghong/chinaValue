//
//  KspHonorListModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspHonorListModel.h"

@implementation KspHonorListModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.ID=[dic objectForKey:@"ID"];
        self.Name=[dic objectForKey:@"Name"];
        self.Year=[dic objectForKey:@"Year"];
        self.Month=[dic objectForKey:@"Month"];
        self.Desc=[dic objectForKey:@"Desc"];
        self.CardUrl=[dic objectForKey:@"CardUrl"];
    }
    return self;
}

@end
