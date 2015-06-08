//
//  ReqListModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqListModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *ReqID;
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *Price;
@property(nonatomic,strong)NSString *PublisherID;
@property(nonatomic,strong)NSString *PublisherName;
@property(nonatomic,strong)NSString *PublisherAvatar;
@property(nonatomic,strong)NSString *Competitors;
@property(nonatomic,strong)NSString *LocationID;
@property(nonatomic,strong)NSString *ReqCountry;
@property(nonatomic,strong)NSString *ReqProvince;
@property(nonatomic,strong)NSString *ReqCity;
@end
