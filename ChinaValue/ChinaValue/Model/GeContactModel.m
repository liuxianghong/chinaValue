//
//  GeContactModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/19.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "GeContactModel.h"

@implementation GeContactModel
-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.UID=[dic objectForKey:@"UID"];
        self.Email=[dic objectForKey:@"Email"];
        self.Mobile=[dic objectForKey:@"Mobile"];
        self.WeChat=[dic objectForKey:@"Wechat"];
        self.Telphone=[dic objectForKey:@"Telphone"];
        self.QQ=[dic objectForKey:@"QQ"];
        self.Other=[dic objectForKey:@"Other"];
        
    }
    
    return  self;
}
@end
