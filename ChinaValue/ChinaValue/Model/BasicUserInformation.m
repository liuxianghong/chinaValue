//
//  BasicUserInformation.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "BasicUserInformation.h"

@implementation BasicUserInformation

//+ (instancetype)sharedManager{
//    static id _sharedInstance = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _sharedInstance = [[self alloc] init];
//    });
//    return _sharedInstance;
//}

-(id )initWithDic:(NSDictionary *)dic{
    self=[super init];
//    [self setValue:[dic objectForKey:@"UserName"] forKey:@"UserName"];
//    [self setValue:[dic objectForKey:@"Sex"] forKey:@"Sex"];
//    [self setValue:[dic objectForKey:@"CompanyName"] forKey:@"CompanyName"];
//    [self setValue:[dic objectForKey:@"DutyName"] forKey:@"DutyName"];
//    [self setValue:[dic objectForKey:@"About"] forKey:@"About"];
//    [self setValue:[dic objectForKey:@"CountryID"] forKey:@"CountryID"];
//    [self setValue:[dic objectForKey:@"Country"] forKey:@"Country"];
//    [self setValue:[dic objectForKey:@"ProvinceID"] forKey:@"ProvinceID"];
//    [self setValue:[dic objectForKey:@"Province"] forKey:@"Province"];
//    [self setValue:[dic objectForKey:@"CityID"] forKey:@"CityID"];
//    [self setValue:[dic objectForKey:@"City"] forKey:@"City"];
//    [self setValue:[dic objectForKey:@"Avatar"] forKey:@"Avatar"];
//    
    
    
    
    self.userName=[dic objectForKey:@"UserName"];
    self.CompanyName=[dic objectForKey:@"CompanyName"];
    self.Sex=[dic objectForKey:@"Sex"];
    self.DutyName=[dic objectForKey:@"DutyName"];
    self.About=[dic objectForKey:@"About"];
    self.CountryID=[dic objectForKey:@"CountryID"];
    self.Country=[dic objectForKey:@"Country"];
    self.ProviceID=[dic objectForKey:@"ProviceID"];
    self.Province=[dic objectForKey:@"Province"];
    self.CityID=[dic objectForKey:@"CityID"];
    self.City=[dic objectForKey:@"City"];
    self.Avatar=[dic objectForKey:@"Avatar"];
    [[NSUserDefaults standardUserDefaults] setObject:self.Avatar forKey:@"Avatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return self;
}

@end
