//
//  GetReqDetailModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/13.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  查看需求详情列表(需求详情列表,点进去查看需求方资料的列表信息)

#import "GetReqDetailModel.h"

@implementation GetReqDetailModel

-(id)initWitDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.ReqID=[dic objectForKey:@"ReqID"];
        self.Title=[dic objectForKey:@"Title"];
        self.AddTime=[dic objectForKey:@"AddTime"];
        self.EndTime=[dic objectForKey:@"EndTime"];
        self.Price=[dic objectForKey:@"Price"];
        self.ServiceType=[dic objectForKey:@"ServiceType"];
        self.LocationID=[dic objectForKey:@"LocationID"];
        self.ReqCountry=[dic objectForKey:@"ReqCountry"];
        self.ReqProvince=[dic objectForKey:@"ReqProvice"];
        self.ReqCity=[dic objectForKey:@"ReqCity"];
        self.Desc=[dic objectForKey:@"Desc"];
        self.PublisherID=[dic objectForKey:@"PublisherID"];
        self.PublisherName=[dic objectForKey:@"PublisherName"];
        self.PublisherAvatar=[dic objectForKey:@"PublisherAvatar"];
        self.PublisherCompany=[dic objectForKey:@"PublisherCompany"];
        self.PublisherDuty=[dic objectForKey:@"PublisherDuty"];
        self.ButtonText=[dic objectForKey:@"ButtonText"];
        self.Industry=[dic objectForKey:@"Industry"];
        self.Function=[dic objectForKey:@"Function"];
    }
    
    return self;
}


@end
