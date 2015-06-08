//
//  GetINdustryModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetINdustryModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Name;

@end
