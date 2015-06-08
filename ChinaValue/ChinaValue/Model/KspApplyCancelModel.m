//
//  KspApplyCancelModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspApplyCancelModel.h"

@implementation KspApplyCancelModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.Result=[dic objectForKey:@"Result"];
        self.Msg=[dic objectForKey:@"Msg"];
    }
    return self;
   
}

@end
