//
//  ReqListModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

//   待解决需求列表(我来服务页面）

#import "ReqListModel.h"

@implementation ReqListModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    
    self.ReqID=[dic objectForKey:@"ReqID"];
    self.Title=[dic objectForKey:@"Title"];
    self.Price=[dic objectForKey:@"Price"];
    self.PublisherID=[dic objectForKey:@"PublisherID"];
    self.PublisherName=[dic objectForKey:@"PublisherName"];
    self.PublisherAvatar=[dic objectForKey:@"PublisherAvatar"];
    self.Competitors=[dic objectForKey:@"Competitors"];
    self.LocationID=[dic objectForKey:@"LocationID"];
    self.ReqCountry=[dic objectForKey:@"ReqCountry"];
    self.ReqProvince=[dic objectForKey:@"ReqProvince"];
    self.ReqCity=[dic objectForKey:@"ReqCity"];
    
    return self;
}

@end
