//
//  BasicUserInformation.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicUserInformation : NSObject
+(instancetype)sharedManager;

-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *Sex;
@property(nonatomic,strong)NSString *CompanyName;
@property(nonatomic,strong)NSString *DutyName;
@property(nonatomic,strong)NSString *About;
@property(nonatomic,strong)NSString *CountryID;
@property(nonatomic,strong)NSString *Country;
@property(nonatomic,strong)NSString *ProviceID;
@property(nonatomic,strong)NSString *Province;
@property(nonatomic,strong)NSString *CityID;
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *Avatar;

@end
