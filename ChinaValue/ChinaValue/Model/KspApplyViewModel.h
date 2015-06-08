//
//  KspApplyViewModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KspApplyViewModel : NSObject

-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *Reason;
@property(nonatomic,strong)NSString *Duration;
@property(nonatomic,strong)NSString *Price;
@property(nonatomic,strong)NSString *LocationID;
@property(nonatomic,strong)NSString *Country;
@property(nonatomic,strong)NSString *Province;
@property(nonatomic,strong)NSString *City;
@end
