//
//  GeContactModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   获取用户联系方式
#import <Foundation/Foundation.h>

@interface GeContactModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *WeChat;
@property(nonatomic,strong)NSString *Telphone;
@property(nonatomic,strong)NSString *QQ;
@property(nonatomic,strong)NSString *Other;

@end
