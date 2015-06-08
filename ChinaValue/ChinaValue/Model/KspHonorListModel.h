//
//  KspHonorListModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KspHonorListModel : NSObject

-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Year;
@property(nonatomic,strong)NSString *Month;
@property(nonatomic,strong)NSString *Desc;
@property(nonatomic,strong)NSString *CardUrl;

@end
