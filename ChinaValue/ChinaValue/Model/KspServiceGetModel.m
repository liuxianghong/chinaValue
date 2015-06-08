//
//  KspServiceGetModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "KspServiceGetModel.h"
@implementation KspServiceGetModel
- (id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.UserName=[dic objectForKey:@"UserName"];
        self.LocationID=[dic objectForKey:@"LocationID"];
        self.Country=[dic objectForKey:@"Country"];
         self.Province=[dic objectForKey:@"Province"];
        self.City=[dic objectForKey:@"City"];
        self.CompanyName=[dic objectForKey:@"CompanyName"];
          self.DutyName=[dic objectForKey:@"DutyName"];
        self.About=[dic objectForKey:@"About"];
        self.Avatar=[dic objectForKey:@"Avatar"];
        self.WorkYear=[dic objectForKey:@"WorkYear"];
        
        self.Function=[dic objectForKey:@"Function"];
        self.Industry=[dic objectForKey:@"Industry"];
        self.FunctionName=[dic objectForKey:@"FunctionName"];
        self.INdustryName=[dic objectForKey:@"IndustryName"];
        self.FunctionKeyword=[dic objectForKey:@"FunctionKeyword"];
        self.IndustryExperience=[dic objectForKey:@"IndustryExperience"];
        self.ServiceDesc=[dic objectForKey:@"ServiceDesc"];
        self.PersonalCase=[dic objectForKey:@"PersonalCase"];
        
    }
    return self;
}


@end
