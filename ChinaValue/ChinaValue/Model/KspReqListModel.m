//
//  KspReqListModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspReqListModel.h"

@implementation KspReqListModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        
        self.ReqID=[dic objectForKey:@"ReqID"];
        self.Title=[dic objectForKey:@"Title"];
        self.AddTime=[dic objectForKey:@"AddTime"];
        self.Status=[dic objectForKey:@"Status"];
        self.EndTime=[dic objectForKey:@"EndTime"];
    }
    
    return  self;
}

@end
