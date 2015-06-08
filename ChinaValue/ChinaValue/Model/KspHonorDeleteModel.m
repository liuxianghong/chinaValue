//
//  KspHonorDeleteModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspHonorDeleteModel.h"

@implementation KspHonorDeleteModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.Result=[dic objectForKey:@"Result"];
    }
    return self;
}

@end
