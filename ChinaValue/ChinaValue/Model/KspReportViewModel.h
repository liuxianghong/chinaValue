//
//  KspReportViewModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KspReportViewModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *Result;
@property(nonatomic,strong)NSString *URL;

@end
