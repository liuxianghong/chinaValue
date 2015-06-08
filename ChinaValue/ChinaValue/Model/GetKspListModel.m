//
//  GetKspListModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/14.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "GetKspListModel.h"

@implementation GetKspListModel
-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.UID=[dic objectForKey:@"UID"];
        self.UserName=[dic objectForKey:@"UserName"];
        self.Sex=[dic objectForKey:@"Sex"];
        self.CompanyName=[dic objectForKey:@"CompanyName"];
        self.DutyName=[dic objectForKey:@"DutyName"];
        self.About=[dic objectForKey:@"About"];
        self.Avatar=[dic objectForKey:@"Avatar"];
    }
   
    return self;
}

@end
