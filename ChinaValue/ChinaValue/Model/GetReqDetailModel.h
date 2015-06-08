//
//  GetReqDetailModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/13.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetReqDetailModel : NSObject

-(id)initWitDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *ReqID;
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *EndTime;
@property(nonatomic,strong)NSString *Price;
@property(nonatomic,strong)NSString *ServiceType;
@property(nonatomic,strong)NSString *LocationID;
@property(nonatomic,strong)NSString *ReqCountry;
@property(nonatomic,strong)NSString *ReqProvince;
@property(nonatomic,strong)NSString *ReqCity;
@property(nonatomic,strong)NSString *Desc;
@property(nonatomic,strong)NSString *PublisherID;
@property(nonatomic,strong)NSString *PublisherName;
@property(nonatomic,strong)NSString *PublisherAvatar;
@property(nonatomic,strong)NSString *PublisherCompany;
@property(nonatomic,strong)NSString *PublisherDuty;
@property(nonatomic,strong)NSString *ButtonText;
@property(nonatomic,strong)NSString *Industry;
@property(nonatomic,strong)NSString *Function;

@property(nonatomic,strong)NSString *IndustryName;

@end
