//
//  KspServiceGetModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KspServiceGetModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;


@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *LocationID;
@property(nonatomic,strong)NSString *Country;
@property(nonatomic,strong)NSString *Province;
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *CompanyName;
@property(nonatomic,strong)NSString *DutyName;
@property(nonatomic,strong)NSString *About;
@property(nonatomic,strong)NSString *Avatar;
@property(nonatomic,strong)NSString *WorkYear;
@property(nonatomic,strong)NSString *Function;
@property(nonatomic,strong)NSString *Industry;
@property(nonatomic,strong)NSString *FunctionName;
@property(nonatomic,strong)NSString *INdustryName;
@property(nonatomic,strong)NSString *FunctionKeyword;
@property(nonatomic,strong)NSString *IndustryExperience;
@property(nonatomic,strong)NSString *ServiceDesc;
@property(nonatomic,strong)NSString *PersonalCase;
@end
