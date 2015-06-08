//
//  UserModel.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//    用户模型
//

#import "UserModel.h"

@implementation UserModel

-(id)init
{
    self = [super init];
    self.userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
    return self;
}

+ (instancetype)sharedManager{
    static id _sharedInstance = nil;     
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
@end
